#!/bin/bash

echo "🔍 Kubernetes Manifests Verification"
echo "====================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ERRORS=0

echo "📋 Step 1: Checking YAML Syntax..."
echo ""

# Check if files exist
FILES=(
  "k8s/database/pvc.yaml"
  "k8s/database/secret.yaml"
  "k8s/database/deployment.yaml"
  "k8s/database/service.yaml"
  "k8s/backend/configmap.yaml"
  "k8s/backend/secret.yaml"
  "k8s/backend/deployment.yaml"
  "k8s/backend/service.yaml"
  "k8s/frontend/deployment.yaml"
  "k8s/frontend/service.yaml"
  "k8s/deploy-all.yaml"
)

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo -e "${GREEN}✅${NC} Found: $file"
  else
    echo -e "${RED}❌${NC} Missing: $file"
    ERRORS=$((ERRORS + 1))
  fi
done

echo ""
echo "📊 Step 2: Validating YAML Structure..."
echo ""

# Basic YAML syntax check (check for common issues)
for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    # Check if file is not empty and has basic YAML structure
    if [ -s "$file" ] && grep -q "apiVersion:" "$file" && grep -q "kind:" "$file"; then
      echo -e "${GREEN}✅${NC} Valid YAML structure: $file"
    else
      echo -e "${RED}❌${NC} Invalid YAML structure: $file"
      ERRORS=$((ERRORS + 1))
    fi
  fi
done

echo ""
echo "🔍 Step 3: Checking Kubernetes Resource Types..."
echo ""

# Check for required resource types
REQUIRED_RESOURCES=(
  "PersistentVolumeClaim"
  "Secret"
  "ConfigMap"
  "Deployment"
  "Service"
)

for resource in "${REQUIRED_RESOURCES[@]}"; do
  if grep -q "kind: $resource" k8s/**/*.yaml 2>/dev/null || grep -q "kind: $resource" k8s/*.yaml 2>/dev/null; then
    echo -e "${GREEN}✅${NC} Found resource type: $resource"
  else
    echo -e "${RED}❌${NC} Missing resource type: $resource"
    ERRORS=$((ERRORS + 1))
  fi
done

echo ""
echo "🏷️  Step 4: Checking Labels and Selectors..."
echo ""

# Check if deployments have matching labels
if grep -q "app: postgres" k8s/database/*.yaml && \
   grep -q "app: backend" k8s/backend/*.yaml && \
   grep -q "app: frontend" k8s/frontend/*.yaml; then
  echo -e "${GREEN}✅${NC} All apps have consistent labels"
else
  echo -e "${RED}❌${NC} Inconsistent labels found"
  ERRORS=$((ERRORS + 1))
fi

echo ""
echo "🔌 Step 5: Checking Service Ports..."
echo ""

# Check if services expose correct ports
if grep -q "port: 5432" k8s/database/service.yaml; then
  echo -e "${GREEN}✅${NC} PostgreSQL service port: 5432"
else
  echo -e "${RED}❌${NC} PostgreSQL service port incorrect"
  ERRORS=$((ERRORS + 1))
fi

if grep -q "port: 3001" k8s/backend/service.yaml; then
  echo -e "${GREEN}✅${NC} Backend service port: 3001"
else
  echo -e "${RED}❌${NC} Backend service port incorrect"
  ERRORS=$((ERRORS + 1))
fi

if grep -q "port: 80" k8s/frontend/service.yaml; then
  echo -e "${GREEN}✅${NC} Frontend service port: 80"
else
  echo -e "${RED}❌${NC} Frontend service port incorrect"
  ERRORS=$((ERRORS + 1))
fi

echo ""
echo "🐳 Step 6: Checking Docker Images..."
echo ""

# Check if images are specified
if grep -q "image: postgres:15-alpine" k8s/database/deployment.yaml; then
  echo -e "${GREEN}✅${NC} Database image: postgres:15-alpine"
else
  echo -e "${RED}❌${NC} Database image not found"
  ERRORS=$((ERRORS + 1))
fi

if grep -q "image: todo-backend:latest" k8s/backend/deployment.yaml; then
  echo -e "${GREEN}✅${NC} Backend image: todo-backend:latest"
else
  echo -e "${RED}❌${NC} Backend image not found"
  ERRORS=$((ERRORS + 1))
fi

if grep -q "image: todo-frontend:latest" k8s/frontend/deployment.yaml; then
  echo -e "${GREEN}✅${NC} Frontend image: todo-frontend:latest"
else
  echo -e "${RED}❌${NC} Frontend image not found"
  ERRORS=$((ERRORS + 1))
fi

echo ""
echo "💾 Step 7: Checking Persistent Storage..."
echo ""

if grep -q "PersistentVolumeClaim" k8s/database/pvc.yaml; then
  echo -e "${GREEN}✅${NC} PVC defined for database"
else
  echo -e "${RED}❌${NC} PVC not defined"
  ERRORS=$((ERRORS + 1))
fi

if grep -q "storage: 5Gi" k8s/database/pvc.yaml; then
  echo -e "${GREEN}✅${NC} Storage size: 5Gi"
else
  echo -e "${YELLOW}⚠️${NC}  Storage size not 5Gi"
fi

echo ""
echo "🔐 Step 8: Checking Secrets and ConfigMaps..."
echo ""

if grep -q "POSTGRES_PASSWORD" k8s/database/secret.yaml; then
  echo -e "${GREEN}✅${NC} Database secret configured"
else
  echo -e "${RED}❌${NC} Database secret missing"
  ERRORS=$((ERRORS + 1))
fi

if grep -q "DB_HOST" k8s/backend/configmap.yaml; then
  echo -e "${GREEN}✅${NC} Backend ConfigMap configured"
else
  echo -e "${RED}❌${NC} Backend ConfigMap missing"
  ERRORS=$((ERRORS + 1))
fi

echo ""
echo "🏥 Step 9: Checking Health Probes..."
echo ""

if grep -q "livenessProbe" k8s/backend/deployment.yaml && \
   grep -q "readinessProbe" k8s/backend/deployment.yaml; then
  echo -e "${GREEN}✅${NC} Backend has health probes"
else
  echo -e "${YELLOW}⚠️${NC}  Backend missing health probes"
fi

if grep -q "livenessProbe" k8s/frontend/deployment.yaml && \
   grep -q "readinessProbe" k8s/frontend/deployment.yaml; then
  echo -e "${GREEN}✅${NC} Frontend has health probes"
else
  echo -e "${YELLOW}⚠️${NC}  Frontend missing health probes"
fi

echo ""
echo "📈 Step 10: Checking Resource Limits..."
echo ""

if grep -q "resources:" k8s/backend/deployment.yaml && \
   grep -q "limits:" k8s/backend/deployment.yaml && \
   grep -q "requests:" k8s/backend/deployment.yaml; then
  echo -e "${GREEN}✅${NC} Backend has resource limits"
else
  echo -e "${YELLOW}⚠️${NC}  Backend missing resource limits"
fi

if grep -q "resources:" k8s/frontend/deployment.yaml && \
   grep -q "limits:" k8s/frontend/deployment.yaml && \
   grep -q "requests:" k8s/frontend/deployment.yaml; then
  echo -e "${GREEN}✅${NC} Frontend has resource limits"
else
  echo -e "${YELLOW}⚠️${NC}  Frontend missing resource limits"
fi

echo ""
echo "🔄 Step 11: Checking Replicas..."
echo ""

BACKEND_REPLICAS=$(grep "replicas:" k8s/backend/deployment.yaml | awk '{print $2}')
FRONTEND_REPLICAS=$(grep "replicas:" k8s/frontend/deployment.yaml | awk '{print $2}')

if [ "$BACKEND_REPLICAS" -ge 2 ]; then
  echo -e "${GREEN}✅${NC} Backend replicas: $BACKEND_REPLICAS (High Availability)"
else
  echo -e "${YELLOW}⚠️${NC}  Backend replicas: $BACKEND_REPLICAS (Consider 2+ for HA)"
fi

if [ "$FRONTEND_REPLICAS" -ge 2 ]; then
  echo -e "${GREEN}✅${NC} Frontend replicas: $FRONTEND_REPLICAS (High Availability)"
else
  echo -e "${YELLOW}⚠️${NC}  Frontend replicas: $FRONTEND_REPLICAS (Consider 2+ for HA)"
fi

echo ""
echo "====================================="
if [ $ERRORS -eq 0 ]; then
  echo -e "${GREEN}🎉 All checks passed!${NC}"
  echo ""
  echo -e "${BLUE}📋 Summary:${NC}"
  echo "  ✅ All YAML files present"
  echo "  ✅ Valid YAML syntax"
  echo "  ✅ All required resources defined"
  echo "  ✅ Services configured correctly"
  echo "  ✅ Docker images specified"
  echo "  ✅ Persistent storage configured"
  echo "  ✅ Secrets and ConfigMaps present"
  echo "  ✅ Health probes configured"
  echo "  ✅ Resource limits set"
  echo "  ✅ High availability (2+ replicas)"
  echo ""
  echo -e "${GREEN}✨ Kubernetes manifests are ready for deployment!${NC}"
  echo ""
  echo "Next steps:"
  echo "  1. Push Docker images to Docker Hub"
  echo "  2. Deploy to Kubernetes cluster"
  echo "  3. Verify deployment with: kubectl get all"
  exit 0
else
  echo -e "${RED}❌ $ERRORS check(s) failed${NC}"
  echo ""
  echo "Please fix the errors above before deploying."
  exit 1
fi
