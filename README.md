# 🚀 Kubernetes 3-Tier Todo App

[![GitHub](https://img.shields.io/badge/GitHub-K8s--todo-blue?logo=github)](https://github.com/AchrefHabhab/K8s-todo)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?logo=kubernetes)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform)](https://www.terraform.io/)

A complete DevOps project demonstrating how to deploy a 3-tier application on AWS EKS (Elastic Kubernetes Service) with Terraform, Docker, and CI/CD automation.

## 📚 What You'll Learn

This project teaches you **real-world DevOps skills** that companies are actively hiring for:

1. **Docker** - Containerizing applications
2. **Kubernetes** - Orchestrating containers at scale
3. **Terraform** - Infrastructure as Code (IaC)
4. **AWS EKS** - Managed Kubernetes on AWS
5. **CI/CD** - Automated deployment with GitHub Actions
6. **ArgoCD** - GitOps deployment
7. **Monitoring** - Prometheus + Grafana

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│                  AWS EKS Cluster                │
│                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌────────┐│
│  │   Frontend   │  │   Backend    │  │  DB    ││
│  │   (React)    │──│  (Node.js)   │──│(Postgres)│
│  │   Port 80    │  │  Port 3001   │  │Port 5432││
│  └──────────────┘  └──────────────┘  └────────┘│
│                                                 │
│  Managed by Kubernetes Deployments & Services  │
└─────────────────────────────────────────────────┘
         ↑
         │ Deployed by
         │
    ┌────────────┐
    │  ArgoCD    │  (GitOps)
    └────────────┘
         ↑
         │ Triggered by
         │
  ┌──────────────────┐
  │ GitHub Actions   │  (CI/CD)
  └──────────────────┘
```

### **3 Tiers Explained:**

1. **Frontend (Tier 1)**: React app served by Nginx
2. **Backend (Tier 2)**: Node.js Express API
3. **Database (Tier 3)**: PostgreSQL database

---

## 📁 Project Structure

```
k8s-todo-app/
├── frontend/              # React frontend
│   ├── src/
│   │   ├── App.jsx       # Main React component
│   │   └── App.css       # Styles
│   ├── Dockerfile        # Multi-stage build
│   ├── nginx.conf        # Nginx config
│   └── package.json
│
├── backend/               # Node.js backend
│   ├── server.js         # Express API
│   ├── Dockerfile        # Backend container
│   ├── package.json
│   └── .env.example
│
├── k8s/                   # Kubernetes manifests
│   ├── frontend/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   ├── backend/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── database/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── pvc.yaml
│
├── terraform/             # Infrastructure as Code
│   ├── main.tf           # EKS cluster
│   ├── variables.tf
│   └── outputs.tf
│
└── .github/workflows/     # CI/CD pipelines
    └── deploy.yml
```

---

## 🎯 Step-by-Step Guide

### **Phase 1: Local Development** (What we're doing now)

1. ✅ Create simple 3-tier app
2. ✅ Test locally with Docker Compose
3. ✅ Verify all tiers communicate

### **Phase 2: Dockerization**

1. Build Docker images
2. Push to Docker Hub
3. Test containers locally

### **Phase 3: Kubernetes Setup**

1. Create Kubernetes manifests
2. Test on local Kubernetes (minikube)
3. Verify deployments and services

### **Phase 4: AWS Infrastructure**

1. Write Terraform code for EKS
2. Provision AWS resources
3. Configure kubectl for EKS

### **Phase 5: Deployment**

1. Deploy to EKS with kubectl
2. Set up ArgoCD for GitOps
3. Configure monitoring

### **Phase 6: CI/CD**

1. Create GitHub Actions workflow
2. Automate build and push
3. Auto-deploy on git push

---

## 🛠️ Technologies Used

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Frontend** | React + Vite | UI framework |
| **Backend** | Node.js + Express | REST API |
| **Database** | PostgreSQL | Data persistence |
| **Containerization** | Docker | Package apps |
| **Orchestration** | Kubernetes | Manage containers |
| **Cloud** | AWS EKS | Managed Kubernetes |
| **IaC** | Terraform | Provision infrastructure |
| **CI/CD** | GitHub Actions | Automation |
| **GitOps** | ArgoCD | Deployment |
| **Monitoring** | Prometheus + Grafana | Observability |

---

## 🚀 Quick Start (Local Development)

### Prerequisites
- Docker installed ✅
- Node.js 18+ installed
- PostgreSQL running locally

### 1. Start Backend

```bash
cd backend
npm install
cp .env.example .env
npm start
```

Backend runs on `http://localhost:3001`

### 2. Start Frontend

```bash
cd frontend
pnpm install
pnpm dev
```

Frontend runs on `http://localhost:5173`

### 3. Test the App

1. Open `http://localhost:5173`
2. Add a todo
3. Check it appears in the list
4. Toggle completion
5. Delete a todo

---

## 🐳 Docker Commands

### Build Images

```bash
# Backend
cd backend
docker build -t your-dockerhub-username/todo-backend:latest .

# Frontend
cd frontend
docker build -t your-dockerhub-username/todo-frontend:latest .
```

### Run with Docker Compose

```bash
docker-compose up
```

---

## ☸️ Kubernetes Deployment (Coming Next)

We'll create Kubernetes manifests for:
- Deployments (how many replicas)
- Services (how to access pods)
- ConfigMaps (environment variables)
- Secrets (database passwords)
- PersistentVolumes (database storage)

---

## 📊 What Makes This Project Special

1. **Real 3-Tier Architecture** - Not a toy app
2. **Production-Ready** - Uses best practices
3. **Full DevOps Pipeline** - From code to cloud
4. **Automated** - CI/CD with GitHub Actions
5. **Monitored** - Prometheus + Grafana
6. **Scalable** - Kubernetes handles scaling
7. **Infrastructure as Code** - Terraform for everything

---

## 🎓 Learning Outcomes

After completing this project, you'll be able to:

✅ Containerize any application with Docker  
✅ Deploy to Kubernetes clusters  
✅ Provision cloud infrastructure with Terraform  
✅ Set up CI/CD pipelines  
✅ Implement GitOps with ArgoCD  
✅ Monitor applications in production  
✅ Debug Kubernetes issues  
✅ Scale applications automatically  

---

## 👤 Author

**Achraf Hebheb**
- GitHub: [@AchrefHabhab](https://github.com/AchrefHabhab)
- LinkedIn: [achraf-hebheb-98a763194](https://linkedin.com/in/achraf-hebheb-98a763194)

---

## 📝 Project Status

1. ✅ Create the app
2. ✅ Test locally with Docker Compose
3. ✅ Dockerize everything
4. ✅ Create Kubernetes manifests
5. ✅ Deploy to local Kubernetes (minikube)
6. ✅ Write Terraform for AWS EKS
7. ✅ Add CI/CD pipeline with GitHub Actions
8. ✅ Set up monitoring with Prometheus and Grafana

**Current Status**: All phases complete! Ready for AWS deployment when credits arrive. ✅

---

**⭐ Star this repo if you find it helpful for learning DevOps!**
