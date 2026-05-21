#!/bin/bash

echo "🔍 Kubernetes Todo App - Verification Script"
echo "=============================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track errors
ERRORS=0

echo "📦 Checking Backend..."
cd backend

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}⚠️  Installing backend dependencies...${NC}"
    pnpm install
fi

# Run ESLint
echo "  Running ESLint..."
if pnpm lint > /dev/null 2>&1; then
    echo -e "  ${GREEN}✅ ESLint passed${NC}"
else
    echo -e "  ${RED}❌ ESLint failed${NC}"
    ERRORS=$((ERRORS + 1))
fi

cd ..

echo ""
echo "🎨 Checking Frontend..."
cd frontend

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}⚠️  Installing frontend dependencies...${NC}"
    pnpm install
fi

# Run ESLint
echo "  Running ESLint..."
if pnpm lint > /dev/null 2>&1; then
    echo -e "  ${GREEN}✅ ESLint passed${NC}"
else
    echo -e "  ${RED}❌ ESLint failed${NC}"
    ERRORS=$((ERRORS + 1))
fi

cd ..

echo ""
echo "🐳 Checking Docker..."
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✅ Docker installed${NC}"
    docker --version
else
    echo -e "${RED}❌ Docker not installed${NC}"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "☸️  Checking kubectl..."
if command -v kubectl &> /dev/null; then
    echo -e "${GREEN}✅ kubectl installed${NC}"
    kubectl version --client --short 2>/dev/null || kubectl version --client
else
    echo -e "${RED}❌ kubectl not installed${NC}"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "🏗️  Checking Terraform..."
if command -v terraform &> /dev/null; then
    echo -e "${GREEN}✅ Terraform installed${NC}"
    terraform --version | head -n 1
else
    echo -e "${RED}❌ Terraform not installed${NC}"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "☁️  Checking AWS CLI..."
if command -v aws &> /dev/null; then
    echo -e "${GREEN}✅ AWS CLI installed${NC}"
    aws --version
else
    echo -e "${RED}❌ AWS CLI not installed${NC}"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "=============================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}🎉 All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Start PostgreSQL: docker-compose up postgres -d"
    echo "  2. Start backend: cd backend && pnpm dev"
    echo "  3. Start frontend: cd frontend && pnpm dev"
    echo "  4. Open http://localhost:5173"
    exit 0
else
    echo -e "${RED}❌ $ERRORS check(s) failed${NC}"
    exit 1
fi
