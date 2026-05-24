# GitHub Actions CI/CD Pipelines

This directory contains automated workflows for continuous integration and deployment.

## 🔄 Workflows

### 1. CI/CD Pipeline (`ci-cd.yml`)

**Triggers:**
- Push to `main` branch
- Pull requests to `main`

**Jobs:**

#### Lint Job
- ✅ ESLint for backend (Node.js)
- ✅ ESLint for frontend (React)
- ✅ Hadolint for Dockerfiles
- ✅ kube-linter for Kubernetes manifests

#### Build & Push Job
- ✅ Build Docker images
- ✅ Push to Docker Hub with version tags
- ✅ Cache layers for faster builds
- ✅ Only runs on `main` branch pushes

#### Security Scan Job
- ✅ Trivy vulnerability scanning
- ✅ Upload results to GitHub Security
- ✅ Scan both backend and frontend images

### 2. Terraform Validation (`terraform.yml`)

**Triggers:**
- Changes to `terraform/` directory

**Jobs:**
- ✅ Format check (`terraform fmt`)
- ✅ Initialize Terraform
- ✅ Validate configuration
- ✅ Dry-run plan (if AWS credentials available)

## 🔐 Required Secrets

Add these secrets in GitHub repository settings:

**Settings → Secrets and variables → Actions → New repository secret**

### Docker Hub
- `DOCKER_PASSWORD` - Your Docker Hub password or access token

### AWS (Optional - for Terraform)
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key

## 📊 Workflow Diagram

```
┌─────────────────────────────────────────────┐
│         Push to main / Pull Request         │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
         ┌─────────────────┐
         │   Lint Job      │
         │  - ESLint       │
         │  - Hadolint     │
         │  - kube-linter  │
         └────────┬────────┘
                  │
                  ▼ (main branch only)
         ┌─────────────────┐
         │ Build & Push    │
         │  - Backend img  │
         │  - Frontend img │
         └────────┬────────┘
                  │
                  ▼
         ┌─────────────────┐
         │ Security Scan   │
         │  - Trivy        │
         │  - Upload SARIF │
         └─────────────────┘
```

## 🚀 How It Works

### On Pull Request
1. Runs linting checks
2. Validates code quality
3. Does NOT build/push images
4. Provides feedback before merge

### On Push to Main
1. Runs all linting checks
2. Builds Docker images
3. Pushes to Docker Hub with:
   - Version tag: `v20240522-abc1234`
   - Latest tag: `latest`
4. Scans images for vulnerabilities
5. Reports security issues

## 🏷️ Version Tagging

Images are tagged with:
- **Date + Git SHA**: `v20240522-abc1234`
- **Latest**: `latest`

Example:
```
achrafhebheb/todo-backend:v20240522-abc1234
achrafhebheb/todo-backend:latest
```

## 📈 Benefits

✅ **Automated testing** - Catch errors before deployment  
✅ **Consistent builds** - Same process every time  
✅ **Security scanning** - Find vulnerabilities early  
✅ **Fast feedback** - Know if PR is safe to merge  
✅ **Version tracking** - Every build is tagged  
✅ **Cache optimization** - Faster build times  

## 🎯 What This Demonstrates

**DevOps Skills:**
- CI/CD pipeline design
- Automated testing
- Docker image management
- Security best practices
- Infrastructure validation
- GitOps workflow

**Tools:**
- GitHub Actions
- Docker Buildx
- Trivy security scanner
- Multiple linters
- Terraform

## 🔧 Local Testing

Test workflows locally with [act](https://github.com/nektos/act):

```bash
# Install act
brew install act

# Run lint job
act -j lint

# Run all jobs (requires secrets)
act push
```

## 📝 Adding New Workflows

1. Create `.github/workflows/your-workflow.yml`
2. Define triggers and jobs
3. Test with pull request
4. Merge to main

## 🎓 Learning Resources

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Docker Build Push Action](https://github.com/docker/build-push-action)
- [Trivy Scanner](https://github.com/aquasecurity/trivy)

---

**Every push triggers quality checks!** 🚀
