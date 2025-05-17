# ──────────────────
# Stage 1: Build PDF
# ──────────────────
FROM texlive/texlive:latest AS builder

WORKDIR /app
COPY my_resume.tex .
COPY sections/ ./sections/
COPY packages.txt .
COPY res.cls .

# install any missing packages, then compile
RUN tlmgr update --self \
 && tlmgr install $(cat packages.txt | xargs) biber \
 && latexmk -pdf -interaction=nonstopmode my_resume.tex

# ────────────────────────
# Stage 2: Serve with nginx
# ────────────────────────
FROM nginx:alpine AS final

# copy the PDF generated in builder
COPY --from=builder /app/my_resume.pdf /usr/share/nginx/html/resume.pdf
COPY index.html             /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
