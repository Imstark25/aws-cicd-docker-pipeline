# 🚀 Quick Start Guide - DevOps CI/CD Project

## ⚡ Get Started in 3 Steps!

### Step 1: Build the Docker Image
```bash
cd devops-cicd-project
docker build -t devops-cicd-app:latest .
```

### Step 2: Run the Container
```bash
docker run -d -p 8080:80 --name my-devops-app devops-cicd-app:latest
```

### Step 3: Open Your Browser
Go to: **http://localhost:8080**

---

## 🛑 Stop & Cleanup
```bash
# Stop and remove the container
docker rm -f my-devops-app

# Remove the image (optional)
docker rmi devops-cicd-app:latest
```

---

## 📊 Useful Commands

### Check Running Containers
```bash
docker ps
```

### View Logs
```bash
docker logs my-devops-app
```

### View All Images
```bash
docker images
```

### Restart Container
```bash
docker restart my-devops-app
```

---

## 🔄 GitHub Setup (Optional)

### Initialize Git and Push to GitHub
```bash
cd devops-cicd-project
git init
git add .
git commit -m "Initial commit: DevOps CI/CD project"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git
git push -u origin main
```

Once pushed, GitHub Actions will automatically run your CI/CD pipeline! 🎉

---

## 📖 Need More Help?
See the full [README.md](README.md) for detailed explanations!
