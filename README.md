# 🚀 DevOps CI/CD Project

![GitHub last commit](https://img.shields.io/github/last-commit/Imstark25/aws-cicd-docker-pipeline)
![GitHub repo size](https://img.shields.io/github/repo-size/Imstark25/aws-cicd-docker-pipeline)

A complete beginner-friendly DevOps project demonstrating containerization with Docker, automated CI/CD pipelines using GitHub Actions, and cloud deployment on AWS EC2.

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Local Setup](#local-setup)
- [Docker Commands Explained](#docker-commands-explained)
- [GitHub Actions CI/CD](#github-actions-cicd)
- [AWS EC2 Deployment](#aws-ec2-deployment)
- [File Explanations](#file-explanations)
- [Learning Outcomes](#learning-outcomes)

## 🎯 Project Overview

This project demonstrates fundamental DevOps practices:
- **Containerization**: Packaging an application with Docker
- **CI/CD**: Automating build and test processes with GitHub Actions
- **Web Serving**: Deploying a static website using Nginx
- **Cloud Deployment**: Hosting on AWS EC2 instances

## 🛠 Technologies Used

- **HTML/CSS**: Simple static web application with modern styling
- **Docker**: Container platform for packaging applications
- **Nginx**: High-performance web server (Alpine Linux version)
- **GitHub Actions**: CI/CD automation platform
- **AWS EC2**: Cloud hosting platform
- **Git**: Version control system

## 📁 Project Structure

```
devops-cicd-project/
│
├── index.html              # Static web page with modern UI
├── Dockerfile              # Docker configuration file
├── README.md               # Main project documentation
├── QUICKSTART.md           # Quick reference guide
├── AWS-DEPLOYMENT.md       # Complete AWS EC2 deployment guide
├── .dockerignore           # Docker build optimization
├── .gitignore              # Git ignore patterns
├── deploy.sh               # Automated deployment script
└── .github/
    └── workflows/
        └── ci.yml          # GitHub Actions CI/CD pipeline
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

## ☁️ AWS EC2 Deployment

### Quick Overview

Deploy your containerized application to AWS EC2 for public access.

### Prerequisites for AWS Deployment

- AWS Account (free tier eligible)
- Basic understanding of SSH
- Your project code pushed to GitHub

### Deployment Steps Summary

1. **Launch EC2 Instance**
   - Choose Ubuntu Server 22.04 LTS
   - Instance type: t2.micro (free tier)
   - Configure security groups (ports 22, 80, 8080)
   - Download key pair for SSH access

2. **Connect to EC2**
   ```bash
   ssh -i your-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
   ```

3. **Install Docker on EC2**
   ```bash
   sudo apt-get update
   sudo apt-get install -y docker.io
   sudo usermod -aG docker $USER
   newgrp docker
   ```

4. **Deploy Your Application**
   ```bash
   git clone https://github.com/YOUR-USERNAME/YOUR-REPO.git
   cd YOUR-REPO
   docker build -t devops-cicd-app:latest .
   docker run -d -p 80:80 --name devops-app --restart unless-stopped devops-cicd-app:latest
   ```

5. **Access Your Application**
   - Open browser: `http://YOUR_EC2_PUBLIC_IP`
   - Your app is now live! 🎉

### Complete Deployment Guide

📖 **See [AWS-DEPLOYMENT.md](AWS-DEPLOYMENT.md) for detailed step-by-step instructions including:**
- Complete AWS account setup
- EC2 instance configuration
- Security group settings
- SSH connection guide (Windows/Mac/Linux)
- Troubleshooting tips
- Continuous deployment strategies
- Cost management advice

### Quick Deployment Script

Once your EC2 is set up, use the `deploy.sh` script for quick deployments:

```bash
chmod +x deploy.sh
./deploy.sh
```

This script automatically:
- Pulls latest code from GitHub
- Rebuilds Docker image
- Restarts the container
- Verifies deployment

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
- ✅ Continuous integration best practices

### Cloud Deployment (AWS)
- ✅ How to launch and configure EC2 instances
- ✅ SSH connection and server management
- ✅ Installing Docker on Linux servers
- ✅ Security group configuration
- ✅ Deploying containers in production
- ✅ Basic AWS cloud computing concepts

### DevOps Best Practices
- ✅ Infrastructure as Code (Dockerfile)
- ✅ Pipeline as Code (GitHub Actions YAML)
- ✅ Automated testing
- ✅ Version control integration
- ✅ Documentation
- ✅ Deployment automation

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
## 🚀 Next Steps

Once you've mastered this project, try these enhancements:

1. **Deploy to AWS EC2** - See [AWS-DEPLOYMENT.md](AWS-DEPLOYMENT.md) ⭐
2. **Add a custom domain** - Point a domain name to your EC2 IP
3. **Enable HTTPS** - Set up SSL certificate with Let's Encrypt
4. **Push to Docker Hub** - Share your image publicly
5. **Implement multi-stage Dockerfile** for optimization
6. **Add automated deployment** on successful builds
7. **Create multiple environments** (dev, staging, production)
8. **Add monitoring** - Set up CloudWatch or Prometheus
9. **Implement load balancing** - Use AWS ELB
10. **Add a database** - Connect to AWS RDS

## 📚 Additional Resources

### Docker & Containerization
- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Nginx Documentation](https://nginx.org/en/docs/)

### CI/CD & GitHub
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

### AWS Cloud
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [AWS Getting Started](https://aws.amazon.com/getting-started/)

### DevOps Learning
- [DevOps Roadmap](https://roadmap.sh/devops)
- [The Phoenix Project (Book)](https://www.amazon.com/Phoenix-Project-DevOps-Helping-Business/dp/0988262592)

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
