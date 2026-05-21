# Kubernetes Manifests

This directory contains all Kubernetes configuration files for deploying the 3-tier Todo application.

## 📁 Structure

```
k8s/
├── database/           # PostgreSQL layer
│   ├── pvc.yaml       # Persistent storage
│   ├── secret.yaml    # Database credentials
│   ├── deployment.yaml # Database pod
│   └── service.yaml   # Internal service
│
├── backend/            # Node.js API layer
│   ├── configmap.yaml # Environment variables
│   ├── secret.yaml    # Sensitive data
│   ├── deployment.yaml # API pods (2 replicas)
│   └── service.yaml   # Internal service
│
├── frontend/           # React + Nginx layer
│   ├── deployment.yaml # Frontend pods (2 replicas)
│   └── service.yaml   # LoadBalancer (external access)
│
└── deploy-all.yaml     # All-in-one deployment file
```

## 🚀 Quick Deploy

### Option 1: Deploy All at Once
```bash
kubectl apply -f k8s/deploy-all.yaml
```

### Option 2: Deploy Layer by Layer
```bash
# 1. Database layer
kubectl apply -f k8s/database/

# 2. Backend layer
kubectl apply -f k8s/backend/

# 3. Frontend layer
kubectl apply -f k8s/frontend/
```

## 📊 Verify Deployment

### Check all resources
```bash
kubectl get all
```

### Check pods
```bash
kubectl get pods
```

### Check services
```bash
kubectl get svc
```

### Check persistent volumes
```bash
kubectl get pvc
```

### Get frontend URL (LoadBalancer)
```bash
kubectl get svc frontend
```

## 🔍 Troubleshooting

### View pod logs
```bash
# Backend logs
kubectl logs -l app=backend

# Frontend logs
kubectl logs -l app=frontend

# Database logs
kubectl logs -l app=postgres
```

### Describe a pod
```bash
kubectl describe pod <pod-name>
```

### Get into a pod
```bash
kubectl exec -it <pod-name> -- /bin/sh
```

## 🎯 Key Concepts Explained

### **Deployments**
- Define desired state (how many replicas)
- Kubernetes ensures actual state matches desired state
- Automatic rollouts and rollbacks

### **Services**
- **ClusterIP**: Internal only (backend, database)
- **LoadBalancer**: External access (frontend)
- Provides stable DNS name for pods

### **ConfigMaps**
- Non-sensitive configuration
- Environment variables
- Can be updated without rebuilding images

### **Secrets**
- Sensitive data (passwords, tokens)
- Base64 encoded
- Should use external secret management in production

### **PersistentVolumeClaim (PVC)**
- Requests storage from cluster
- Data persists even if pod dies
- Essential for databases

### **Resource Limits**
- **Requests**: Minimum guaranteed resources
- **Limits**: Maximum allowed resources
- Prevents one app from starving others

### **Probes**
- **Liveness**: Is the app alive? (restart if fails)
- **Readiness**: Is the app ready for traffic?
- Ensures zero-downtime deployments

## 🔄 Update Strategy

### Update image version
```bash
kubectl set image deployment/backend backend=todo-backend:v2
```

### Rollback deployment
```bash
kubectl rollout undo deployment/backend
```

### Check rollout status
```bash
kubectl rollout status deployment/backend
```

## 🧹 Cleanup

### Delete all resources
```bash
kubectl delete -f k8s/deploy-all.yaml
```

### Or delete by layer
```bash
kubectl delete -f k8s/frontend/
kubectl delete -f k8s/backend/
kubectl delete -f k8s/database/
```

## 📈 Scaling

### Scale backend
```bash
kubectl scale deployment backend --replicas=5
```

### Scale frontend
```bash
kubectl scale deployment frontend --replicas=3
```

### Auto-scaling (HPA)
```bash
kubectl autoscale deployment backend --cpu-percent=70 --min=2 --max=10
```

## 🎓 What This Demonstrates

✅ **Multi-tier architecture** in Kubernetes  
✅ **Service discovery** (pods find each other by name)  
✅ **Persistent storage** for stateful apps  
✅ **Secrets management** for sensitive data  
✅ **Resource management** (requests/limits)  
✅ **Health checks** (liveness/readiness probes)  
✅ **High availability** (multiple replicas)  
✅ **Load balancing** (automatic with Service)  

---

**Next Steps:**
1. Test on local Kubernetes (minikube/kind)
2. Deploy to AWS EKS
3. Add CI/CD pipeline
4. Set up monitoring
