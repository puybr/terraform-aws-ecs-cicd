# 🚜 AWS Docker Infrastructure

### Terraform Modules:
1. ecr-infra
2. ecs-infra
3. codepipeline

### How to setup:
- Configure the AWS providers profile in the "`main.tf`" file located in each module
- See the how-to guide [here](./fargate/README.md)
- `aws configure [--profile profile-name]`

### How to run:
```sh
cd fargate/<MODULE>/
terraform init
terraform plan
terraform apply
```

### AWS Resources:
- [x] **Virtual Private Cloud** (VPC)
    - Subnets
    - Internet Gateway
    - Route Tables
    - NAT Gateway
- [x] **Application Load Balancer** (ALB)
    - ALB Target Group
    - ALB Listener
    - ALB Health Checks
- [x] **IAM Policies & Roles**
- [x] **Security Groups**
- [x] **Elastic Container Service** (ECS)
    - ECS Cluster
    - ECS Task Definition
    - ECS Service
- [x] **Elastic Container Registry** (ECR)
- [x] **[Codestar Connection](https://docs.aws.amazon.com/codepipeline/latest/userguide/connections-github.html)**
- [x] **CodePipeline**
- [x] **CodeBuild**
- [x] **CodeDeploy**
- [X] **S3 Bucket Artifacts**
