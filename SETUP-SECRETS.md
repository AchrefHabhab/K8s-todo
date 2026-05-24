# 🔐 GitHub Secrets Setup Guide

To enable CI/CD automation, you need to add secrets to your GitHub repository.

## Required Secrets

### 1. Docker Hub Password

**Why needed:** GitHub Actions needs to push Docker images to Docker Hub

**Steps:**

1. **Get Docker Hub Access Token** (Recommended over password)
   - Go to https://hub.docker.com/settings/security
   - Click "New Access Token"
   - Name: `github-actions`
   - Permissions: Read, Write, Delete
   - Copy the token (you won't see it again!)

2. **Add to GitHub**
   - Go to your repo: https://github.com/AchrefHabhab/K8s-todo
   - Click **Settings** → **Secrets and variables** → **Actions**
   - Click **New repository secret**
   - Name: `DOCKER_PASSWORD`
   - Value: Paste your Docker Hub access token
   - Click **Add secret**

### 2. AWS Credentials (Optional - for Terraform validation)

**Why needed:** To validate Terraform plans in CI/CD

**Only add these when you have AWS credits:**

1. **Get AWS Credentials**
   - From AWS Educate or GitHub Student Pack
   - You'll get: Access Key ID and Secret Access Key

2. **Add to GitHub**
   - `AWS_ACCESS_KEY_ID` - Your AWS access key
   - `AWS_SECRET_ACCESS_KEY` - Your AWS secret key

## ✅ Verify Setup

After adding secrets:

1. Go to **Actions** tab in your GitHub repo
2. You should see workflows running
3. Check that "Build & Push" job succeeds

## 🔒 Security Best Practices

✅ **Use Access Tokens** instead of passwords  
✅ **Limit token permissions** to only what's needed  
✅ **Rotate tokens** every 90 days  
✅ **Never commit secrets** to code  
✅ **Use GitHub Secrets** for sensitive data  

## 🚨 If Token is Compromised

1. Revoke token immediately in Docker Hub
2. Delete secret from GitHub
3. Create new token
4. Add new secret to GitHub

---

**Setup takes 2 minutes!** 🚀
