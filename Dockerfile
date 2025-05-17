FROM nginx:alpine

# Copy the resume PDF
COPY my_resume.pdf /usr/share/nginx/html/resume.pdf

# Copy the index.html that redirects to the resume
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Default command to start nginx
CMD ["nginx", "-g", "daemon off;"]
