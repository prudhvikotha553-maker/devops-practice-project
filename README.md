# DevOps Practice Project

Complete DevOps learning environment with Docker, Kubernetes, and CI/CD.

## 🚀 Quick Start

### Option 1: Docker Development (Easiest - Start Here!)

1. Open Command Prompt in project folder
2. Run: `scripts\start-docker.bat`
3. Wait 2-3 minutes for build
4. Open browser: http://localhost:3000

### Option 2: Manual Docker Commands

```bash
# Build and start
docker-compose up --build

# In another terminal, check if running:
docker ps

# Stop everything:
docker-compose down
```

## 📁 Project Structure

```
devops-practice-project/
├── frontend/           # React application
├── backend/            # Node.js API
├── kubernetes/         # K8s configs
├── scripts/            # Helper scripts
└── docker-compose.yml  # Docker orchestration
```

## ✅ What You Have Now

- ✅ Frontend: React app
- ✅ Backend: Node.js API
- ✅ Docker: Complete containerization
- ✅ Ready to run locally!

## 🎯 Learning Path

### Week 1: Docker Basics (Current Step)
1. Run with Docker Compose
2. See frontend and backend working together
3. Make small changes and rebuild

### Week 2: Kubernetes (Coming Next)
- Deploy to local K8s cluster
- Understand pods and services

## 🆘 Troubleshooting

**Port already in use?**
```bash
# Stop all Docker containers
docker-compose down
```

**Build errors?**
```bash
# Clean rebuild
docker-compose down
docker-compose up --build
```

**Can't see the app?**
- Wait 2-3 minutes for first build
- Check: http://localhost:3000
- Check Docker Desktop - containers should be running

Prod deployment trigger test


