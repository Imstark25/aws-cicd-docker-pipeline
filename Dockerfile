# Use the official Nginx image from Docker Hub as the base image
# Nginx is a lightweight, high-performance web server
FROM nginx:alpine

# Set maintainer label (optional but good practice)
LABEL maintainer="devops-learner"
LABEL description="Beginner-friendly DevOps CI/CD project with Docker and Nginx"

# Copy the HTML file from the current directory to the Nginx web directory
# Nginx serves files from /usr/share/nginx/html by default
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to allow external access to the web server
# This is the default HTTP port
EXPOSE 80

# The CMD instruction is inherited from the nginx:alpine base image
# It starts the Nginx server in the foreground
# No need to specify it again, but for clarity:
# CMD ["nginx", "-g", "daemon off;"]
