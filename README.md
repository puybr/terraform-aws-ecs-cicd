# 🚜 AWS Docker Infrastructure

### Terraform Modules:
1. [ecr-infra](./fargate/ecr-infra)
2. [ecs-infra](./fargate/ecs-infra)
3. [codepipeline](./fargate/codepipeline)

### How to setup:
- Clone the repository
- Rename the repository folder to the application name: `nodejs-express`:
- `mv aws-iac-fargate nodejs-express`
- `cd nodejs-express/fargate`
- `cd <MODULE>`
- Modify the AWS providers profile in the "`main.tf`" file located in each module
    - See the how-to guide [here](./fargate/README.md)
    - `aws configure [--profile profile-name]`
- Configure the [Codestar Connection](https://docs.aws.amazon.com/codepipeline/latest/userguide/connections-github.html)
- Add a "`terraform.tfvars`" file in each module directory and set the variables:
```sh
aws_region=
app_name=
app_port=
app_count=
...
```

### How to run:
```sh
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
    - ALB Target Groups
    - ALB HTTP Listener
    - ALB Rules
    - ALB Health Checks
- [ ] **IAM Roles & Policies**
- [x] **Security Groups**
- [x] **Systems Manager Parameter Store** (SSM)
- [x] **Elastic Container Registry** (ECR)
- [x] **Elastic Container Service** (ECS)
    - ECS Cluster
    - ECS Task Definition
    - ECS Service
- [x] **CodePipeline**
- [x] **CodeBuild**
- [x] **CodeDeploy**
- [X] **S3 Bucket Artifacts**
