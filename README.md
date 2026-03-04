# 🚀 DevOps CI/CD Project

A beginner-friendly DevOps project demonstrating containerization with Docker and automated CI/CD pipelines using GitHub Actions.

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Local Setup](#local-setup)
- [Docker Commands Explained](#docker-commands-explained)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [File Explanations](#file-explanations)
- [Learning Outcomes](#learning-outcomes)

## 🎯 Project Overview

This project demonstrates fundamental DevOps practices:
- **Containerization**: Packaging an application with Docker
- **CI/CD**: Automating build and test processes with GitHub Actions
- **Web Serving**: Deploying a static website using Nginx

## 🛠 Technologies Used

- **HTML**: Simple static web application
- **Docker**: Container platform for packaging applications
- **Nginx**: High-performance web server (Alpine Linux version)
- **GitHub Actions**: CI/CD automation platform

## 📁 Project Structure

```
devops-cicd-project/
│
├── index.html          # Static web page
├── Dockerfile          # Docker configuration file
├── README.md           # Project documentation (this file)
└── .github/
    └── workflows/
        └── ci.yml      # GitHub Actions CI/CD pipeline
```

## ✅ Prerequisites

Before you begin, ensure you have the following installed:

1. **Docker Desktop**: [Download here](https://www.docker.com/products/docker-desktop)
   - For Windows: Docker Desktop for Windows
   - For Mac: Docker Desktop for Mac
   - For Linux: Docker Engine

2. **Git**: [Download here](https://git-scm.com/downloads)

3. **Text Editor**: VS Code, Sublime Text, or any editor of your choice

## 🚀 Local Setup

### Step 1: Clone or Download the Project

```bash
# If you have this project in a Git repository
git clone <your-repository-url>
cd devops-cicd-project

# Or simply navigate to the project directory
cd devops-cicd-project
```

### Step 2: Build the Docker Image

```bash
docker build -t devops-cicd-app:latest .
```

**What this command does:**
- `docker build`: Tells Docker to build an image
- `-t devops-cicd-app:latest`: Tags the image with a name and version
- `.`: Uses the Dockerfile in the current directory

### Step 3: Run the Docker Container

```bash
docker run -d -p 8080:80 --name my-devops-app devops-cicd-app:latest
```

**What this command does:**
- `docker run`: Creates and starts a container
- `-d`: Runs container in detached mode (background)
- `-p 8080:80`: Maps port 8080 on your machine to port 80 in the container
- `--name my-devops-app`: Gives the container a friendly name
- `devops-cicd-app:latest`: Specifies which image to use

### Step 4: Access the Application

Open your web browser and visit: **http://localhost:8080**

You should see your web application running! 🎉

### Step 5: Useful Docker Commands

```bash
# View running containers
docker ps

# View all containers (including stopped ones)
docker ps -a

# View Docker images
docker images

# View container logs
docker logs my-devops-app

# Stop the container
docker stop my-devops-app

# Start the container again
docker start my-devops-app

# Remove the container
docker rm my-devops-app

# Remove the image
docker rmi devops-cicd-app:latest

# Stop and remove container in one command
docker rm -f my-devops-app
```

## 🐳 Docker Commands Explained

### Building Docker Images

```bash
docker build -t <image-name>:<tag> <build-context>
```

- **image-name**: A friendly name for your image (e.g., `devops-cicd-app`)
- **tag**: Version identifier (e.g., `latest`, `v1.0`, `dev`)
- **build-context**: Path to the directory containing the Dockerfile (`.` means current directory)

### Running Docker Containers

```bash
docker run [OPTIONS] <image-name>:<tag>
```

**Common Options:**
- `-d`: Detached mode (run in background)
- `-p HOST_PORT:CONTAINER_PORT`: Port mapping
- `--name`: Assign a name to the container
- `-e`: Set environment variables
- `-v`: Mount volumes (for persistent data)
- `--rm`: Automatically remove container when it stops

### Example with Multiple Options

```bash
docker run -d \
  -p 8080:80 \
  --name my-app \
  -e ENV=production \
  --restart unless-stopped \
  devops-cicd-app:latest
```

## 🔄 GitHub Actions CI/CD

### What is GitHub Actions?

GitHub Actions is a CI/CD platform that automates your build, test, and deployment pipeline. When you push code to GitHub, Actions automatically:

1. ✅ Builds your Docker image
2. ✅ Verifies the build succeeded
3. ✅ Runs the container for testing
4. ✅ Tests if the application is accessible
5. ✅ Cleans up test resources

### How to Enable GitHub Actions

1. **Create a GitHub Repository**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit: DevOps CI/CD project"
   git branch -M main
   git remote add origin <your-github-repo-url>
   git push -u origin main
   ```

2. **GitHub Actions Runs Automatically**:
   - Go to your repository on GitHub
   - Click the "Actions" tab
   - You'll see your workflow running automatically on every push!

3. **View Workflow Results**:
   - Green checkmark ✅ = Success
   - Red X ❌ = Failure
   - Click on any workflow run to see detailed logs

## 📄 File Explanations

### 1. `index.html`

A simple, modern HTML page with CSS styling. This is your web application that will be served by Nginx inside the Docker container.

**Key Features:**
- Responsive design
- Modern CSS with gradients and animations
- Clear messaging about the DevOps technologies used

### 2. `Dockerfile`

The blueprint for creating your Docker image.

```dockerfile
# Base image: Use Nginx Alpine (lightweight Linux)
FROM nginx:alpine

# Metadata about the image
LABEL maintainer="devops-learner"

# Copy your HTML file into Nginx's web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 for HTTP traffic
EXPOSE 80
```

**Line-by-Line Explanation:**
- `FROM nginx:alpine`: Start with a pre-built Nginx image (Alpine is a small Linux distribution)
- `LABEL`: Add metadata to your image (good practice for documentation)
- `COPY`: Copy files from your local machine into the container
- `EXPOSE`: Document which port the container listens on

### 3. `.github/workflows/ci.yml`

The CI/CD pipeline configuration for GitHub Actions.

**Workflow Structure:**
```yaml
name: Workflow name
on: When to trigger
jobs:
  build:
    runs-on: What OS to use
    steps:
      - Step 1
      - Step 2
      - ...
```

**What Each Step Does:**
1. **Checkout Code**: Downloads your repository code
2. **Set up Docker Buildx**: Prepares advanced Docker build features
3. **Build Docker Image**: Creates the Docker image
4. **Verify Docker Image**: Confirms the image was created
5. **Run Docker Container**: Starts a test container
6. **Test Application**: Checks if the application is accessible
7. **Cleanup**: Removes test containers (runs even if previous steps fail)
8. **Success**: Displays a success message

## 🎓 Learning Outcomes

After completing this project, you will understand:

### Docker Concepts
- ✅ What containers are and why they're useful
- ✅ How to write a Dockerfile
- ✅ How to build Docker images
- ✅ How to run containers
- ✅ Port mapping and networking basics
- ✅ Container lifecycle management

### CI/CD Concepts
- ✅ What CI/CD is and why it matters
- ✅ How to create GitHub Actions workflows
- ✅ Automated testing and validation
- ✅ Pipeline stages and steps
- ✅ Build automation

### DevOps Best Practices
- ✅ Infrastructure as Code (Dockerfile)
- ✅ Pipeline as Code (GitHub Actions YAML)
- ✅ Automated testing
- ✅ Version control integration
- ✅ Documentation

## 🔧 Troubleshooting

### Issue: Port Already in Use

**Error:** `Bind for 0.0.0.0:8080 failed: port is already allocated`

**Solution:**
```bash
# Use a different port
docker run -d -p 8081:80 --name my-devops-app devops-cicd-app:latest

# Or find and stop the process using port 8080
docker ps
docker stop <container-using-port-8080>
```

### Issue: Docker Daemon Not Running

**Error:** `Cannot connect to the Docker daemon`

**Solution:**
- Start Docker Desktop application
- Wait for Docker to fully initialize
- Try the command again

### Issue: Permission Denied (Linux)

**Error:** `Permission denied while trying to connect to Docker daemon`

**Solution:**
```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker
```

## 🚀 Next Steps

Once you've mastered this project, try these enhancements:

1. **Add more features to the web app** (JavaScript, forms, etc.)
2. **Push the Docker image to Docker Hub**
3. **Deploy to cloud platforms** (AWS, Azure, Google Cloud)
4. **Add security scanning** to the CI/CD pipeline
5. **Implement multi-stage Dockerfile** for optimization
6. **Add automated deployment** on successful builds
7. **Create multiple environments** (dev, staging, production)

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Hub](https://hub.docker.com/)

## 📝 License

This project is open source and available for learning purposes.

## 🤝 Contributing

Feel free to fork this project and enhance it! Some ideas:
- Add more detailed documentation
- Create additional examples
- Improve the web interface
- Add more CI/CD steps

---

**Happy Learning! 🎉**

If you found this project helpful, please give it a ⭐ on GitHub!
