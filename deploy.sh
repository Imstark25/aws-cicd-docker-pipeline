#!/bin/bash

# =========================================
# Deployment Script for DevOps CI/CD Project
# =========================================
# This script automates the deployment process on AWS EC2

echo "🚀 Starting deployment process..."
echo "=================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="devops-app"
IMAGE_NAME="devops-cicd-app"
IMAGE_TAG="latest"
CONTAINER_PORT=80
HOST_PORT=80

# Step 1: Pull latest code from GitHub
echo -e "\n${BLUE}📥 Step 1: Pulling latest code from GitHub...${NC}"
if git pull origin main; then
    echo -e "${GREEN}✅ Code updated successfully${NC}"
else
    echo -e "${RED}❌ Failed to pull latest code${NC}"
    echo "Make sure you're in a git repository and have internet access"
    exit 1
fi

# Step 2: Stop existing container
echo -e "\n${BLUE}🛑 Step 2: Stopping existing container...${NC}"
if docker stop $APP_NAME 2>/dev/null; then
    echo -e "${GREEN}✅ Container stopped${NC}"
else
    echo "No running container found (this is okay for first deployment)"
fi

# Step 3: Remove existing container
echo -e "\n${BLUE}🗑️  Step 3: Removing existing container...${NC}"
if docker rm $APP_NAME 2>/dev/null; then
    echo -e "${GREEN}✅ Container removed${NC}"
else
    echo "No container to remove (this is okay for first deployment)"
fi

# Step 4: Remove old image (optional - comment out if you want to keep old images)
echo -e "\n${BLUE}🗑️  Step 4: Removing old Docker image...${NC}"
if docker rmi $IMAGE_NAME:$IMAGE_TAG 2>/dev/null; then
    echo -e "${GREEN}✅ Old image removed${NC}"
else
    echo "No old image to remove (this is okay for first deployment)"
fi

# Step 5: Build new Docker image
echo -e "\n${BLUE}🔨 Step 5: Building new Docker image...${NC}"
if docker build -t $IMAGE_NAME:$IMAGE_TAG .; then
    echo -e "${GREEN}✅ Docker image built successfully${NC}"
else
    echo -e "${RED}❌ Failed to build Docker image${NC}"
    exit 1
fi

# Step 6: Run new container
echo -e "\n${BLUE}▶️  Step 6: Starting new container...${NC}"
if docker run -d \
    -p $HOST_PORT:$CONTAINER_PORT \
    --name $APP_NAME \
    --restart unless-stopped \
    $IMAGE_NAME:$IMAGE_TAG; then
    echo -e "${GREEN}✅ Container started successfully${NC}"
else
    echo -e "${RED}❌ Failed to start container${NC}"
    exit 1
fi

# Step 7: Wait for application to start
echo -e "\n${BLUE}⏳ Step 7: Waiting for application to start...${NC}"
sleep 3

# Step 8: Verify deployment
echo -e "\n${BLUE}✅ Step 8: Verifying deployment...${NC}"
if docker ps | grep -q $APP_NAME; then
    echo -e "${GREEN}✅ Container is running!${NC}"
    
    # Display container info
    echo -e "\n${BLUE}📊 Container Status:${NC}"
    docker ps | grep $APP_NAME
    
    # Test application locally
    echo -e "\n${BLUE}🧪 Testing application...${NC}"
    sleep 2
    if curl -f http://localhost:$HOST_PORT > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Application is responding!${NC}"
    else
        echo -e "${RED}⚠️  Warning: Application might not be responding correctly${NC}"
        echo "Check container logs: docker logs $APP_NAME"
    fi
else
    echo -e "${RED}❌ Container is not running${NC}"
    echo "Check logs with: docker logs $APP_NAME"
    exit 1
fi

# Step 9: Get public IP (if on EC2)
echo -e "\n${BLUE}🌐 Step 9: Getting access URLs...${NC}"
if command -v ec2metadata > /dev/null 2>&1; then
    PUBLIC_IP=$(ec2metadata --public-ipv4 2>/dev/null)
elif curl -s --max-time 2 http://169.254.169.254/latest/meta-data/public-ipv4 > /dev/null 2>&1; then
    PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
else
    PUBLIC_IP="localhost"
fi

# Display success message
echo -e "\n${GREEN}=================================="
echo "🎉 Deployment Completed Successfully!"
echo "==================================${NC}"
echo ""
echo "📍 Application Details:"
echo "   Container Name: $APP_NAME"
echo "   Image: $IMAGE_NAME:$IMAGE_TAG"
echo "   Port: $HOST_PORT"
echo ""
echo "🌐 Access your application at:"
if [ "$PUBLIC_IP" != "localhost" ]; then
    echo "   http://$PUBLIC_IP"
    echo "   http://$PUBLIC_IP:$HOST_PORT"
else
    echo "   http://localhost:$HOST_PORT"
fi
echo ""
echo "📝 Useful Commands:"
echo "   View logs: docker logs $APP_NAME"
echo "   Follow logs: docker logs -f $APP_NAME"
echo "   Stop app: docker stop $APP_NAME"
echo "   Restart app: docker restart $APP_NAME"
echo ""
echo -e "${GREEN}Happy DevOps! 🚀${NC}"
