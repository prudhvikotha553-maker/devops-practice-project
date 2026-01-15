@echo off
echo =====================================================
echo PHASE 2: Creating Application Code Files
echo =====================================================
echo.

REM ===== FRONTEND SOURCE FILES =====
echo Creating Frontend React application...

REM frontend/src/index.js
(
echo import React from 'react';
echo import ReactDOM from 'react-dom/client';
echo import App from './App';
echo.
echo const root = ReactDOM.createRoot^(document.getElementById^('root'^)^);
echo root.render^(
echo   ^<React.StrictMode^>
echo     ^<App /^>
echo   ^</React.StrictMode^>
echo ^);
) > frontend\src\index.js

REM frontend/src/App.js
(
echo import React, { useState, useEffect } from 'react';
echo import axios from 'axios';
echo.
echo const API_URL = process.env.REACT_APP_API_URL ^|^| 'http://localhost:5000';
echo.
echo function App^(^) {
echo   const [message, setMessage] = useState^(''^);
echo   const [environment, setEnvironment] = useState^(''^);
echo   const [loading, setLoading] = useState^(true^);
echo.
echo   useEffect^(^(^) =^> {
echo     fetchData^(^);
echo   }, []^);
echo.
echo   const fetchData = async ^(^) =^> {
echo     try {
echo       const response = await axios.get^(`${API_URL}/api/health`^);
echo       setMessage^(response.data.message^);
echo       setEnvironment^(response.data.environment^);
echo       setLoading^(false^);
echo     } catch ^(error^) {
echo       console.error^('Error:', error^);
echo       setMessage^('Unable to connect to backend'^);
echo       setLoading^(false^);
echo     }
echo   };
echo.
echo   return ^(
echo     ^<div style={{fontFamily: 'Arial', maxWidth: '800px', margin: '50px auto', padding: '20px', textAlign: 'center'}}^>
echo       ^<h1^>🚀 DevOps Practice Application^</h1^>
echo       ^<div style={{backgroundColor: '#f0f0f0', padding: '30px', borderRadius: '10px', marginTop: '30px'}}^>
echo         {loading ? ^<p^>Loading...^</p^> : ^(
echo           ^<^>
echo             ^<h2^>Backend Status^</h2^>
echo             ^<p style={{fontSize: '20px', color: '#4CAF50'}}^>{message}^</p^>
echo             ^<p^>^<strong^>Environment:^</strong^> {environment}^</p^>
echo           ^</^>
echo         ^)}
echo       ^</div^>
echo       ^<div style={{marginTop: '40px', textAlign: 'left'}}^>
echo         ^<h3^>✅ Setup Checklist:^</h3^>
echo         ^<ul^>
echo           ^<li^>Frontend: React Application^</li^>
echo           ^<li^>Backend: Node.js/Express API^</li^>
echo           ^<li^>Docker: Containerized Services^</li^>
echo           ^<li^>Kubernetes: Local Deployment^</li^>
echo         ^</ul^>
echo       ^</div^>
echo     ^</div^>
echo   ^);
echo }
echo.
echo export default App;
) > frontend\src\App.js

REM Frontend Dockerfile
(
echo FROM node:18-alpine AS build
echo WORKDIR /app
echo COPY package*.json ./
echo RUN npm ci --only=production
echo COPY . .
echo RUN npm run build
echo.
echo FROM nginx:alpine
echo COPY --from=build /app/build /usr/share/nginx/html
echo COPY nginx.conf /etc/nginx/conf.d/default.conf
echo EXPOSE 80
echo CMD ["nginx", "-g", "daemon off;"]
) > frontend\Dockerfile

REM Frontend nginx.conf
(
echo server {
echo     listen 80;
echo     location / {
echo         root /usr/share/nginx/html;
echo         index index.html;
echo         try_files $uri $uri/ /index.html;
echo     }
echo }
) > frontend\nginx.conf

echo ✅ Frontend code created!
echo.

REM ===== BACKEND SOURCE FILES =====
echo Creating Backend Node.js application...

REM backend/src/server.js
(
echo const express = require^('express'^);
echo const cors = require^('cors'^);
echo require^('dotenv'^).config^(^);
echo.
echo const app = express^(^);
echo const PORT = process.env.PORT ^|^| 5000;
echo const ENVIRONMENT = process.env.ENVIRONMENT ^|^| 'development';
echo.
echo app.use^(cors^(^)^);
echo app.use^(express.json^(^)^);
echo.
echo app.get^('/api/health', ^(req, res^) =^> {
echo   res.json^({
echo     status: 'success',
echo     message: 'Backend is running!',
echo     environment: ENVIRONMENT,
echo     timestamp: new Date^(^).toISOString^(^)
echo   }^);
echo }^);
echo.
echo app.get^('/api/data', ^(req, res^) =^> {
echo   res.json^({
echo     status: 'success',
echo     data: {
echo       users: 150,
echo       activeUsers: 42,
echo       requests: 1337
echo     }
echo   }^);
echo }^);
echo.
echo app.listen^(PORT, ^(^) =^> {
echo   console.log^(`🚀 Backend server running on port ${PORT}`^);
echo   console.log^(`📍 Environment: ${ENVIRONMENT}`^);
echo }^);
) > backend\src\server.js

REM Backend Dockerfile
(
echo FROM node:18-alpine
echo WORKDIR /app
echo COPY package*.json ./
echo RUN npm ci --only=production
echo COPY . .
echo EXPOSE 5000
echo CMD ["npm", "start"]
) > backend\Dockerfile

echo ✅ Backend code created!
echo.

REM ===== BUILD SCRIPTS =====
echo Creating build and deployment scripts...

REM Build Docker images script
(
echo @echo off
echo echo 🔨 Building Docker images...
echo docker build -t frontend-app:latest ./frontend
echo docker build -t backend-app:latest ./backend
echo echo ✅ Images built successfully!
echo pause
) > scripts\build-images.bat

REM Start with Docker Compose script
(
echo @echo off
echo echo 🐳 Starting application with Docker Compose...
echo docker-compose up --build
) > scripts\start-docker.bat

REM Stop Docker Compose script
(
echo @echo off
echo echo 🛑 Stopping Docker Compose...
echo docker-compose down
echo echo ✅ Stopped!
echo pause
) > scripts\stop-docker.bat

echo ✅ Scripts created!
echo.

REM ===== README =====
echo Creating documentation...

(
echo # DevOps Practice Project
echo.
echo Complete DevOps learning environment with Docker, Kubernetes, and CI/CD.
echo.
echo ## 🚀 Quick Start
echo.
echo ### Option 1: Docker Development ^(Easiest - Start Here!^)
echo.
echo 1. Open Command Prompt in project folder
echo 2. Run: `scripts\start-docker.bat`
echo 3. Wait 2-3 minutes for build
echo 4. Open browser: http://localhost:3000
echo.
echo ### Option 2: Manual Docker Commands
echo.
echo ```bash
echo # Build and start
echo docker-compose up --build
echo.
echo # In another terminal, check if running:
echo docker ps
echo.
echo # Stop everything:
echo docker-compose down
echo ```
echo.
echo ## 📁 Project Structure
echo.
echo ```
echo devops-practice-project/
echo ├── frontend/           # React application
echo ├── backend/            # Node.js API
echo ├── kubernetes/         # K8s configs
echo ├── scripts/            # Helper scripts
echo └── docker-compose.yml  # Docker orchestration
echo ```
echo.
echo ## ✅ What You Have Now
echo.
echo - ✅ Frontend: React app
echo - ✅ Backend: Node.js API
echo - ✅ Docker: Complete containerization
echo - ✅ Ready to run locally!
echo.
echo ## 🎯 Learning Path
echo.
echo ### Week 1: Docker Basics ^(Current Step^)
echo 1. Run with Docker Compose
echo 2. See frontend and backend working together
echo 3. Make small changes and rebuild
echo.
echo ### Week 2: Kubernetes ^(Coming Next^)
echo - Deploy to local K8s cluster
echo - Understand pods and services
echo.
echo ## 🆘 Troubleshooting
echo.
echo **Port already in use?**
echo ```bash
echo # Stop all Docker containers
echo docker-compose down
echo ```
echo.
echo **Build errors?**
echo ```bash
echo # Clean rebuild
echo docker-compose down
echo docker-compose up --build
echo ```
echo.
echo **Can't see the app?**
echo - Wait 2-3 minutes for first build
echo - Check: http://localhost:3000
echo - Check Docker Desktop - containers should be running
echo.
) > README.md

echo ✅ Documentation created!
echo.

echo =====================================================
echo ✅ PHASE 2 COMPLETE!
echo =====================================================
echo.
echo 📂 All files created successfully!
echo.
echo 🎯 NEXT STEP: Test Your Application
echo.
echo Run: scripts\start-docker.bat
echo.
echo Or manually run: docker-compose up --build
echo.
echo Then open: http://localhost:3000
echo.
pause