@echo off
echo 🔨 Building Docker images...
docker build -t frontend-app:latest ./frontend
docker build -t backend-app:latest ./backend
echo ✅ Images built successfully!
pause
