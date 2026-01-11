import React, { useEffect, useState } from "react";

function App() {
  const [status, setStatus] = useState("Loading...");
  const [environment, setEnvironment] = useState("");

  useEffect(() => {
    fetch("/api/health")
      .then((res) => res.json())
      .then((data) => {
        setStatus(data.message);
        setEnvironment(data.environment);
      })
      .catch(() => {
        setStatus("Backend not reachable");
      });
  }, []);

  return (
    <div style={{ padding: "40px", fontFamily: "Arial" }}>
      <h1>🚀 DevOps Practice Application</h1>

      <div style={{ marginTop: "30px", padding: "20px", border: "1px solid #ccc" }}>
        <h2>Backend Status</h2>
        <p style={{ color: "green" }}>{status}</p>
        <p>
          <strong>Environment:</strong> {environment}
        </p>
      </div>

      <div style={{ marginTop: "30px" }}>
        <h3>✅ Setup Checklist:</h3>
        <ul>
          <li>Frontend: React Application</li>
          <li>Backend: Node.js / Express API</li>
          <li>Docker: Containerized Services</li>
          <li>Kubernetes: Local Deployment</li>
        </ul>
      </div>
    </div>
  );
}

export default App;
