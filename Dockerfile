# ───────────────────────────────────────────────────────────
# Stage 1: Builder
# ───────────────────────────────────────────────────────────
FROM alpine:3.18 AS builder

# (If you need any PDF-building tools, install them here.
#  For example, uncomment to install pandoc+TeX:
# RUN apk add --no-cache pandoc texlive)

WORKDIR /app

# Copy your already-built PDF into the builder image
# (This assumes my_resume.pdf was produced earlier in your CI 
#  and is present in the repo root.)
COPY my_resume.pdf .



# ───────────────────────────────────────────────────────────
# Stage 2: Final nginx image
# ───────────────────────────────────────────────────────────
FROM nginx:alpine

# Copy the resume PDF from the builder stage
COPY --from=builder /app/my_resume.pdf /usr/share/nginx/html/resume.pdf

# Copy an index.html that, e.g., redirects or links to resume.pdf
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 and run nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
