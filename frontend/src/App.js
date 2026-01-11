import React, { useState, useEffect } from 'react';
import axios from 'axios';

// Backend is accessed via the SAME host using /api
// Ingress will route /api → backend-service
const API_URL = '';

function App() {
  const [message, setMessage] = useState('');
  const [environment, setEnvironment] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const response = await axios.get(`/api/health`);
      setMessage(response.data.message);
      setEnvironment(response.data.environment);
      setLoading(false);
    } catch (error) {
      console.error('Error:', error);
      setMessage('Unable to connect to backend');
      setLoading(false);
    }
  };

  return (
    <div style={{fontFamily: 'Arial', maxWidth: '800px', margin: '50px auto', padding: '20px', textAlign: 'center'}}>
      <h1>🚀 DevOps Practice Application</h1>
      <div style={{backgroundColor: '#f0f0f0', padding: '30px', borderRadius: '10px', marginTop: '30px'}}>
        {loading ? <p>Loading...</p> : (
          <>
            <h2>Backend Status</h2>
            <p style={{fontSize: '20px', color: '#4CAF50'}}>{message}</p>
            <p><strong>Environment:</strong> {environment}</p>
          </>
        )}
      </div>
    </div>
  );
}

export default App;