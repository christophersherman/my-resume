FROM texlive/texlive:latest AS builder
WORKDIR /app
COPY . .

RUN tlmgr update --self \
 && (tlmgr install $(cat packages.txt | xargs) biber || true) \
 && latexmk -pdf -interaction=nonstopmode my_resume.tex

FROM nginx:alpine AS final
COPY --from=builder /app/my_resume.pdf /usr/share/nginx/html/resume.pdf
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
