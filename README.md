# 🚜 AWS Docker Infrastructure

### Terraform Modules:
1. [ecr-infra](./fargate/ecr-infra)
2. [ecs-infra](./fargate/ecs-infra)
3. [codepipeline](./fargate/codepipeline)

### How to setup:
- Configure the AWS providers profile in the "`main.tf`" file located in each module
- See the how-to guide [here](./fargate/README.md)
- `aws configure [--profile profile-name]`
- Add the [Codestar Connection](https://docs.aws.amazon.com/codepipeline/latest/userguide/connections-github.html)

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
- [x] **IAM Roles & Policies**
- [x] **Security Groups**
- [x] **Elastic Container Registry** (ECR)
- [x] **Elastic Container Service** (ECS)
    - ECS Cluster
    - ECS Task Definition
    - ECS Service
- [x] **CodePipeline**
- [x] **CodeBuild**
- [x] **CodeDeploy**
- [X] **S3 Bucket Artifacts**
