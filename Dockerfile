FROM texlive/texlive:latest AS builder
WORKDIR /app
COPY my_resume.tex res.cls ./
COPY sections/ sections/

RUN latexmk -pdf -interaction=nonstopmode my_resume.tex

FROM nginx:alpine AS final
COPY --from=builder /app/my_resume.pdf /usr/share/nginx/html/resume.pdf
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
