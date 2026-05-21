# 🧪 Testing Checklist

## ✅ Local Development Testing

### Backend Tests
- [x] PostgreSQL container running
- [x] Backend server starts successfully
- [x] Health endpoint responds: `curl http://localhost:3001/health`
- [ ] GET /api/todos returns empty array initially
- [ ] POST /api/todos creates a new todo
- [ ] PUT /api/todos/:id updates a todo
- [ ] DELETE /api/todos/:id deletes a todo
- [ ] Database persists data after restart

### Frontend Tests
- [x] Frontend dev server starts
- [x] App loads in browser at http://localhost:5173
- [ ] Can add a new todo
- [ ] Todo appears in the list
- [ ] Can toggle todo completion
- [ ] Completed todos show strikethrough
- [ ] Can delete a todo
- [ ] Stats update correctly (active/completed/total)
- [ ] Error handling works (disconnect backend and try)

### Code Quality
- [x] Backend ESLint passes: `cd backend && pnpm lint`
- [x] Frontend ESLint passes: `cd frontend && pnpm lint`
- [x] No console errors in browser
- [x] No runtime errors

---

## 🐳 Docker Testing (Next Phase)

### Build Tests
- [ ] Backend Docker image builds: `docker build -t todo-backend ./backend`
- [ ] Frontend Docker image builds: `docker build -t todo-frontend ./frontend`
- [ ] Images are optimized (reasonable size)

### Container Tests
- [ ] All containers start with docker-compose
- [ ] Frontend can reach backend
- [ ] Backend can reach database
- [ ] App works same as local dev

### Commands
```bash
# Build all images
docker-compose build

# Start all services
docker-compose up

# Test in browser
open http://localhost

# Stop all services
docker-compose down
```

---

## ☸️ Kubernetes Manifests Verification

### Validation Tests
- [x] All YAML files present (11 files)
- [x] Valid YAML structure
- [x] All required resource types defined
- [x] Services configured correctly
- [x] Docker images specified
- [x] Persistent storage configured (5Gi)
- [x] Secrets and ConfigMaps present
- [x] Health probes configured (liveness + readiness)
- [x] Resource limits set (requests + limits)
- [x] High availability (2+ replicas)

### Commands
```bash
# Verify manifests
./verify-k8s.sh
```

---

## ☸️ Kubernetes Deployment Testing (Future Phase)

### Manifest Tests
- [ ] All YAML files are valid
- [ ] Deployments create pods successfully
- [ ] Services expose pods correctly
- [ ] ConfigMaps and Secrets work
- [ ] PersistentVolume claims succeed

### Cluster Tests
- [ ] Pods are running: `kubectl get pods`
- [ ] Services are accessible: `kubectl get svc`
- [ ] Logs show no errors: `kubectl logs <pod-name>`
- [ ] Can access app through LoadBalancer/Ingress

---

## 🚀 AWS EKS Testing (Final Phase)

### Infrastructure Tests
- [ ] Terraform plan succeeds
- [ ] Terraform apply creates EKS cluster
- [ ] kubectl can connect to EKS
- [ ] Nodes are ready

### Deployment Tests
- [ ] App deploys to EKS
- [ ] LoadBalancer gets external IP
- [ ] Can access app from internet
- [ ] Monitoring works (Prometheus/Grafana)

### CI/CD Tests
- [ ] GitHub Actions workflow triggers on push
- [ ] Docker images build and push
- [ ] ArgoCD syncs changes
- [ ] Rolling updates work without downtime

---

## 📊 Manual Test Scenarios

### Scenario 1: Basic CRUD
1. Add todo "Buy groceries"
2. Add todo "Learn Kubernetes"
3. Toggle "Buy groceries" as completed
4. Delete "Buy groceries"
5. Verify only "Learn Kubernetes" remains

### Scenario 2: Persistence
1. Add 3 todos
2. Refresh the page
3. Verify all 3 todos still exist

### Scenario 3: Error Handling
1. Stop the backend server
2. Try to add a todo
3. Verify error message appears
4. Start backend again
5. Verify app recovers

### Scenario 4: Multiple Users (Docker)
1. Open app in 2 different browsers
2. Add todo in browser 1
3. Refresh browser 2
4. Verify todo appears in both

---

## 🎯 Current Status

**Phase**: Local Development ✅

**Completed**:
- ✅ Backend running on port 3001
- ✅ Frontend running on port 5173
- ✅ PostgreSQL running in Docker
- ✅ Health check working
- ✅ ESLint passing

**Next**: Test the app manually in browser!

---

## 📝 Test Results Log

### Test Run: May 21, 2026

**Environment**: Local Development

| Test | Status | Notes |
|------|--------|-------|
| Backend starts | ✅ PASS | Port 3001 |
| Frontend starts | ✅ PASS | Port 5173 |
| Database connects | ✅ PASS | PostgreSQL ready |
| Health endpoint | ✅ PASS | Returns healthy status |
| ESLint backend | ✅ PASS | No errors |
| ESLint frontend | ✅ PASS | No errors |
| Add todo | ⏳ PENDING | Test in browser |
| Toggle todo | ⏳ PENDING | Test in browser |
| Delete todo | ⏳ PENDING | Test in browser |

---

**Next Action**: Open http://localhost:5173 and test the UI! 🚀
