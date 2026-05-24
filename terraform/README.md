# Terraform - AWS EKS Infrastructure

This directory contains Terraform code to provision AWS EKS infrastructure for the Todo app.

## 📁 Files

- **providers.tf** - AWS and Kubernetes provider configuration
- **variables.tf** - Input variables with defaults
- **vpc.tf** - VPC, subnets, NAT gateway
- **eks.tf** - EKS cluster and node groups
- **outputs.tf** - Output values after deployment

## 🏗️ Infrastructure Components

### VPC & Networking
- VPC with CIDR 10.0.0.0/16
- Public and private subnets across 3 AZs
- NAT Gateway for private subnet internet access
- Internet Gateway for public subnets

### EKS Cluster
- Kubernetes version 1.28
- Managed node group with t3.medium instances
- Auto-scaling: 1-4 nodes (default: 2)
- Public API endpoint

## 💰 Cost Estimate

**Monthly costs (approximate):**
- EKS Control Plane: **$73/month** ($0.10/hour)
- EC2 Instances (2x t3.medium): **~$60/month**
- NAT Gateway: **~$32/month**
- EBS Volumes: **~$5/month**
- **Total: ~$170/month**

**Cost optimization tips:**
- Use t3.small instead of t3.medium: saves ~$20/month
- Single NAT gateway (already configured)
- Delete when not in use: `terraform destroy`

## 🚀 Usage

### Prerequisites

1. **AWS CLI configured**
   ```bash
   aws configure
   ```

2. **AWS credentials** (from AWS Educate or GitHub Student Pack)
   - Access Key ID
   - Secret Access Key
   - Region: us-east-1

### Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply changes (create infrastructure)
terraform apply

# Get kubectl config
aws eks --region us-east-1 update-kubeconfig --name todo-app-eks
```

### Deploy Application

```bash
# After EKS is ready, deploy the app
kubectl apply -f ../k8s/deploy-all.yaml

# Check status
kubectl get all

# Get LoadBalancer URL
kubectl get svc frontend
```

### Destroy Infrastructure

```bash
# Delete Kubernetes resources first
kubectl delete -f ../k8s/deploy-all.yaml

# Destroy AWS infrastructure
terraform destroy
```

## ⚙️ Configuration

### Change Region

```bash
terraform apply -var="aws_region=eu-central-1"
```

### Change Instance Type

```bash
terraform apply -var="node_instance_type=t3.small"
```

### Scale Nodes

```bash
terraform apply -var="node_desired_size=3"
```

## 📊 What This Demonstrates

✅ **Infrastructure as Code (IaC)** - Reproducible infrastructure  
✅ **AWS VPC** - Networking best practices  
✅ **EKS** - Managed Kubernetes on AWS  
✅ **Auto-scaling** - Dynamic node scaling  
✅ **High Availability** - Multi-AZ deployment  
✅ **Security** - Private subnets for workloads  
✅ **Terraform modules** - Reusable components  

## 🎓 Learning Resources

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
- [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

## ⚠️ Important Notes

1. **DO NOT commit terraform.tfstate** - Contains sensitive data
2. **DO NOT commit .terraform/** - Large directory with providers
3. **Always run `terraform destroy`** when done to avoid charges
4. **Use AWS Free Tier** or student credits to minimize costs

## 🔒 Security Best Practices

- ✅ Private subnets for worker nodes
- ✅ Public subnets only for load balancers
- ✅ Security groups managed by EKS
- ✅ IAM roles for service accounts (IRSA)
- ✅ Encrypted EBS volumes
- ✅ VPC flow logs (can be enabled)

---

**Ready to deploy when AWS credits arrive!** 🚀
