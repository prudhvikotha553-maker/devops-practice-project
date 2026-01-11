const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

/**
 * Environment (dev | qa | uat | prod)
 * MUST be provided by Kubernetes / Docker
 */
const ENVIRONMENT = process.env.ENVIRONMENT || 'dev';

app.use(cors());
app.use(express.json());

/**
 * Root route
 */
app.get('/', (req, res) => {
  res.send('Backend API is running 🚀');
});

/**
 * Infra / Kubernetes health check
 */
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'UP',
    service: 'backend',
    environment: ENVIRONMENT
  });
});

/**
 * Application health check (used by frontend)
 */
app.get('/api/health', (req, res) => {
  res.json({
    status: 'success',
    message: 'Backend is running!',
    environment: ENVIRONMENT,
    timestamp: new Date().toISOString()
  });
});

/**
 * Sample API
 */
app.get('/api/data', (req, res) => {
  res.json({
    status: 'success',
    data: {
      users: 150,
      activeUsers: 42,
      requests: 1337
    }
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Backend server running on port ${PORT}`);
  console.log(`📍 Environment: ${ENVIRONMENT}`);
});
