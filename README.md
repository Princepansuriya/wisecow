# 🐮 Wisecow Kubernetes Deployment (with TLS & CI/CD)

This project containerizes and deploys the **Wisecow Web Application** on a Kubernetes cluster (Minikube / Kind / Any K8s).  
It also integrates **GitHub Actions CI/CD** to build & push Docker images automatically and includes secure **TLS ingress**.

---

## 📌 Features
- Containerized Wisecow Application (Docker)
- Kubernetes Deployment + Service
- TLS-secured access via Ingress
- Automated CI Pipeline using GitHub Actions
- System Health Monitoring Script
- Application Health Check Script

---

## 📂 Project Structure
wisecow/
├── .github/workflows/docker-ci.yml # CI Pipeline
├── k8s/
│ ├── wisecow-deployment.yaml # K8s Deployment
│ ├── wisecow-service.yaml # K8s Service
│ └── wisecow-ingress.yaml # TLS Ingress Rule
├── wisecow.sh # Application Source
├── Dockerfile # Image Build Definition
├── wisecow.crt # SSL Certificate
├── wisecow.key # SSL Private Key
├── health_monitor.sh # System Health Checker Script
├── app_health_check.sh # App Uptime and Status Checker
└── README.md


#1. Build & Push Docker Image
   docker build -t <dockerhub-user>/wisecow:latest .
   docker push <dockerhub-user>/wisecow:latest


2. Deploy to Kubernetes

   Apply Deployment & Service:
      kubectl apply -f k8s/wisecow-deployment.yaml
      kubectl apply -f k8s/wisecow-service.yaml

   Verify:
      kubectl get pods
      kubectl get svc
   
4. TLS Enabled Ingress

Apply TLS certificate secret:
   kubectl create secret tls wisecow-tls \
     --cert=wisecow.crt \
     --key=wisecow.key

   Apply ingress:
      kubectl apply -f k8s/wisecow-ingress.yaml

4. CI/CD - GitHub Actions
  The workflow file is located at:
      .github/workflows/docker-ci.yml

   Pipeline Actions:
      Runs on push to main
      Builds Docker image
      Pushes image to Docker Hub
   
   Required GitHub Secrets
      | Name                 | Value                    |
      | -------------------- | ------------------------ |
      | `DOCKERHUB_USERNAME` | Your Docker Hub Username |
      | `DOCKERHUB_TOKEN`    | Docker Hub Access Token  |


5. System Health Monitoring Script
   chmod +x health_monitor.sh
   ./health_monitor.sh

  <img width="1919" height="1020" alt="Screenshot 2025-10-31 194645" src="https://github.com/user-attachments/assets/31f758df-c4ca-430b-ac8b-56f230f740d2" />

   Logs metrics like:
      CPU usage
      Memory consumption
      Disk usage
      Running processes

7. Application Health Check Script
  chmod +x app_health_check.sh
   ./app_health_check.sh

 

Checks if application is:
   UP (200 OK) → running correctly
   DOWN → service not responding
