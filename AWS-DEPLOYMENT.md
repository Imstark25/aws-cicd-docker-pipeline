# 🚀 AWS EC2 Deployment Guide

Complete step-by-step guide to deploy your Dockerized application on AWS EC2.

## 📋 Table of Contents
1. [Prerequisites](#prerequisites)
2. [AWS Account Setup](#aws-account-setup)
3. [Launch EC2 Instance](#launch-ec2-instance)
4. [Connect to EC2](#connect-to-ec2)
5. [Install Docker on EC2](#install-docker-on-ec2)
6. [Deploy Application](#deploy-application)
7. [Configure Security Groups](#configure-security-groups)
8. [Access Your Application](#access-your-application)
9. [Troubleshooting](#troubleshooting)
10. [Continuous Deployment](#continuous-deployment)

---

## ✅ Prerequisites

Before you begin, ensure you have:
- AWS Account (Free tier eligible)
- Basic understanding of SSH and command line
- Your project code in a GitHub repository
- Credit/debit card for AWS verification (free tier won't charge for basic usage)

---

## 🔐 AWS Account Setup

### Step 1: Create AWS Account
1. Go to [aws.amazon.com](https://aws.amazon.com)
2. Click **"Create an AWS Account"**
3. Follow the registration process
4. Verify your email and phone number
5. Add payment method (required even for free tier)

### Step 2: Sign in to AWS Console
1. Go to [console.aws.amazon.com](https://console.aws.amazon.com)
2. Sign in with your credentials
3. Select your preferred region (e.g., US East (N. Virginia) - us-east-1)

---

## 🖥️ Launch EC2 Instance

### Step 1: Navigate to EC2 Dashboard
1. In AWS Console, search for **"EC2"** in the top search bar
2. Click on **"EC2"** to open the EC2 Dashboard
3. Click **"Launch Instance"** button

### Step 2: Configure Instance

#### Name and Tags
- **Name**: `devops-cicd-server` or any name you prefer

#### Application and OS Images (Amazon Machine Image)
- **Quick Start**: Select **Ubuntu**
- **AMI**: Choose **Ubuntu Server 22.04 LTS (Free tier eligible)**
- Architecture: **64-bit (x86)**

#### Instance Type
- Select **t2.micro** (Free tier eligible)
- 1 vCPU, 1 GiB Memory

#### Key Pair (Login)
- Click **"Create new key pair"**
- Key pair name: `devops-cicd-key`
- Key pair type: **RSA**
- Private key file format: 
  - Windows users: **`.ppk`** (for PuTTY) or **`.pem`** (for OpenSSH)
  - Mac/Linux users: **`.pem`**
- Click **"Create key pair"**
- **IMPORTANT**: Save the downloaded key file securely! You'll need it to connect.

#### Network Settings
- Create new security group or use existing
- Security group name: `devops-cicd-sg`
- Description: `Security group for DevOps CI/CD project`
- **Inbound rules**:
  - ✅ SSH (Port 22) - Source: My IP (for security)
  - ✅ HTTP (Port 80) - Source: Anywhere (0.0.0.0/0)
  - ✅ Custom TCP (Port 8080) - Source: Anywhere (0.0.0.0/0)

#### Configure Storage
- **Size**: 8 GiB (default, sufficient for our needs)
- **Volume type**: gp3 (General Purpose SSD)

### Step 3: Review and Launch
1. Review all settings
2. Click **"Launch Instance"**
3. Wait for the instance to start (Status: Running)
4. Note down your **Public IPv4 address** and **Public IPv4 DNS**

---

## 🔌 Connect to EC2

### For Windows Users

#### Method 1: Using PowerShell (Recommended)

1. **Set proper permissions for your key file**:
```powershell
# Navigate to the folder containing your key
cd C:\Users\YourUsername\Downloads

# If you downloaded .pem file
icacls devops-cicd-key.pem /inheritance:r
icacls devops-cicd-key.pem /grant:r "%username%:R"
```

2. **Connect via SSH**:
```powershell
ssh -i devops-cicd-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
```

Replace `YOUR_EC2_PUBLIC_IP` with your actual EC2 public IP address.

#### Method 2: Using PuTTY

1. Download and install [PuTTY](https://www.putty.org/)
2. Open PuTTY
3. In **Host Name**: Enter `ubuntu@YOUR_EC2_PUBLIC_IP`
4. Port: `22`
5. Connection type: SSH
6. Under **Connection > SSH > Auth > Credentials**:
   - Browse and select your `.ppk` file
7. Click **"Open"**
8. Click **"Yes"** to accept the security alert

### For Mac/Linux Users

1. **Set proper permissions**:
```bash
chmod 400 ~/Downloads/devops-cicd-key.pem
```

2. **Connect via SSH**:
```bash
ssh -i ~/Downloads/devops-cicd-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
```

### Successful Connection
You should see:
```
Welcome to Ubuntu 22.04 LTS
...
ubuntu@ip-xxx-xx-xx-xxx:~$
```

---

## 🐳 Install Docker on EC2

Once connected to your EC2 instance, run these commands:

### Step 1: Update Package Index
```bash
sudo apt-get update
```

### Step 2: Install Required Packages
```bash
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

### Step 3: Add Docker's Official GPG Key
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### Step 4: Set Up Docker Repository
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### Step 5: Install Docker Engine
```bash
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Step 6: Verify Docker Installation
```bash
sudo docker --version
sudo docker run hello-world
```

### Step 7: Add User to Docker Group (Optional but Recommended)
```bash
sudo usermod -aG docker $USER
newgrp docker
```

This allows you to run Docker commands without `sudo`.

### Step 8: Verify You Can Run Docker Without Sudo
```bash
docker --version
docker ps
```

---

## 🚀 Deploy Application

### Step 1: Install Git (if not already installed)
```bash
sudo apt-get install -y git
```

### Step 2: Clone Your Repository
```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
cd YOUR-REPO-NAME
```

**Replace** `YOUR-USERNAME` and `YOUR-REPO-NAME` with your actual GitHub details.

Example:
```bash
git clone https://github.com/Imstark25/aws-cicd-docker-pipeline.git
cd aws-cicd-docker-pipeline
```

### Step 3: Build Docker Image
```bash
docker build -t devops-cicd-app:latest .
```

### Step 4: Run Docker Container
```bash
docker run -d -p 80:80 --name devops-app --restart unless-stopped devops-cicd-app:latest
```

**Command Explanation:**
- `-d`: Run in detached mode (background)
- `-p 80:80`: Map host port 80 to container port 80
- `--name devops-app`: Name the container
- `--restart unless-stopped`: Auto-restart container if it crashes
- `devops-cicd-app:latest`: The image to use

### Step 5: Verify Container is Running
```bash
docker ps
```

You should see your container listed and running.

### Step 6: Test Locally on EC2
```bash
curl http://localhost
```

You should see your HTML content.

---

## 🔒 Configure Security Groups

If you can't access your application from the internet, configure security groups:

### Step 1: Go to EC2 Dashboard
1. Click on your instance
2. Go to **"Security"** tab
3. Click on the security group link

### Step 2: Edit Inbound Rules
1. Click **"Edit inbound rules"**
2. Click **"Add rule"**
3. Configure:
   - **Type**: HTTP
   - **Protocol**: TCP
   - **Port Range**: 80
   - **Source**: 0.0.0.0/0 (Anywhere IPv4)
   - **Description**: HTTP access
4. Click **"Add rule"** again for alternative port:
   - **Type**: Custom TCP
   - **Protocol**: TCP
   - **Port Range**: 8080
   - **Source**: 0.0.0.0/0
   - **Description**: Alternative HTTP port
5. Click **"Save rules"**

---

## 🌐 Access Your Application

### From Your Browser
Open your web browser and navigate to:

```
http://YOUR_EC2_PUBLIC_IP
```

or

```
http://YOUR_EC2_PUBLIC_DNS
```

**Find your IP/DNS:**
- Go to EC2 Dashboard
- Select your instance
- Look for **"Public IPv4 address"** or **"Public IPv4 DNS"**

**Example:**
```
http://54.123.45.67
http://ec2-54-123-45-67.compute-1.amazonaws.com
```

🎉 **You should see your application running!**

---

## 🔧 Troubleshooting

### Issue 1: Can't Connect to EC2 via SSH

**Symptoms**: Connection timeout or refused

**Solutions**:
1. Check security group allows SSH (port 22) from your IP
2. Verify you're using the correct key file
3. Ensure key permissions are correct (400 for Linux/Mac)
4. Check if EC2 instance is running
5. Verify you're using correct username (`ubuntu` for Ubuntu AMI)

### Issue 2: Can't Access Application in Browser

**Symptoms**: Browser shows "This site can't be reached"

**Solutions**:
1. Verify Docker container is running: `docker ps`
2. Check security group allows HTTP (port 80)
3. Test locally on EC2: `curl http://localhost`
4. Restart container: `docker restart devops-app`
5. Check container logs: `docker logs devops-app`

### Issue 3: Docker Permission Denied

**Symptoms**: `permission denied while trying to connect to Docker daemon`

**Solution**:
```bash
sudo usermod -aG docker $USER
newgrp docker
# Or logout and login again
```

### Issue 4: Container Exits Immediately

**Symptoms**: Container starts then stops

**Solutions**:
1. Check container logs:
```bash
docker logs devops-app
```
2. Check if port is already in use:
```bash
sudo netstat -tulpn | grep :80
```
3. Try running on different port:
```bash
docker run -d -p 8080:80 --name devops-app devops-cicd-app:latest
```

### Issue 5: Changes Not Reflected

**Solution**: Rebuild and redeploy
```bash
# Stop and remove old container
docker stop devops-app
docker rm devops-app

# Remove old image
docker rmi devops-cicd-app:latest

# Pull latest code
git pull origin main

# Rebuild and run
docker build -t devops-cicd-app:latest .
docker run -d -p 80:80 --name devops-app --restart unless-stopped devops-cicd-app:latest
```

---

## 🔄 Continuous Deployment

### Manual Deployment Script

Create a deployment script on your EC2 instance:

```bash
nano deploy.sh
```

Add this content:
```bash
#!/bin/bash
echo "🚀 Starting deployment..."

# Pull latest code
echo "📥 Pulling latest code from GitHub..."
git pull origin main

# Stop and remove existing container
echo "🛑 Stopping existing container..."
docker stop devops-app || true
docker rm devops-app || true

# Remove old image
echo "🗑️ Removing old image..."
docker rmi devops-cicd-app:latest || true

# Build new image
echo "🔨 Building Docker image..."
docker build -t devops-cicd-app:latest .

# Run new container
echo "▶️ Starting new container..."
docker run -d -p 80:80 --name devops-app --restart unless-stopped devops-cicd-app:latest

# Verify deployment
echo "✅ Verifying deployment..."
sleep 3
docker ps | grep devops-app

echo "🎉 Deployment completed successfully!"
echo "🌐 Access your app at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
```

Make it executable:
```bash
chmod +x deploy.sh
```

Run deployment:
```bash
./deploy.sh
```

### Automated Deployment with GitHub Actions (Advanced)

For automatic deployment on every push, you'll need to:
1. Set up GitHub Actions self-hosted runner on EC2, OR
2. Use GitHub Secrets to store SSH keys and deploy via SSH, OR
3. Use AWS services like CodeDeploy

See the main README for links to advanced deployment tutorials.

---

## 💰 Cost Management

### Free Tier Limits
- **EC2 t2.micro**: 750 hours/month (1 instance running 24/7)
- **Storage**: 30 GB
- **Data Transfer**: 15 GB outbound per month

### Tips to Avoid Charges
1. ⏹️ Stop instances when not in use (stops compute charges, retains storage)
2. 🗑️ Terminate instances you don't need
3. 📊 Set up billing alerts in AWS Console
4. 🔍 Regularly check AWS Cost Explorer

### Stop Your Instance (Preserves Data)
```
AWS Console > EC2 > Instances > Select Instance > Instance State > Stop
```

### Terminate Your Instance (Deletes Everything)
```
AWS Console > EC2 > Instances > Select Instance > Instance State > Terminate
```

---

## 📚 Useful Commands Reference

### Docker Commands on EC2
```bash
# View running containers
docker ps

# View all containers
docker ps -a

# View logs
docker logs devops-app

# Follow logs in real-time
docker logs -f devops-app

# Stop container
docker stop devops-app

# Start container
docker start devops-app

# Restart container
docker restart devops-app

# Remove container
docker rm devops-app

# Remove image
docker rmi devops-cicd-app:latest

# View Docker images
docker images

# Clean up unused resources
docker system prune -a
```

### EC2 Instance Info
```bash
# Get public IP
curl http://169.254.169.254/latest/meta-data/public-ipv4

# Get instance ID
curl http://169.254.169.254/latest/meta-data/instance-id

# Check system resources
htop  # Install with: sudo apt-get install htop

# Check disk space
df -h

# Check memory usage
free -h
```

---

## 🎓 What You've Learned

By completing this deployment, you now understand:

- ✅ How to launch and configure AWS EC2 instances
- ✅ How to connect to remote servers via SSH
- ✅ How to install Docker on Ubuntu Linux
- ✅ How to deploy containerized applications
- ✅ How to configure AWS security groups
- ✅ How to manage Docker containers in production
- ✅ Basic DevOps deployment workflows
- ✅ Troubleshooting cloud deployments

---

## 🚀 Next Steps

1. **Custom Domain**: Point a domain name to your EC2 IP
2. **HTTPS/SSL**: Set up SSL certificate with Let's Encrypt
3. **Load Balancer**: Use AWS ELB for high availability
4. **Auto Scaling**: Configure auto-scaling groups
5. **Monitoring**: Set up CloudWatch for monitoring
6. **CI/CD Pipeline**: Automate deployment with GitHub Actions
7. **Database**: Add RDS database to your application
8. **CDN**: Use CloudFront for faster content delivery

---

## 📖 Additional Resources

- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Docker Documentation](https://docs.docker.com/)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [Ubuntu Server Guide](https://ubuntu.com/server/docs)

---

**Congratulations! 🎉** 

You've successfully deployed your first DevOps project to AWS EC2!

If you encounter any issues, review the troubleshooting section or check the GitHub repository issues page.
