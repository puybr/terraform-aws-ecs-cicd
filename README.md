# 🚜 AWS Docker Infrastructure

### Terraform Modules:
1. [ecr-infra](./fargate/ecr-infra)
2. [ecs-infra](./fargate/ecs-infra)
3. [codepipeline](./fargate/codepipeline)

### How to setup:
- Configure the [Codestar Connection](https://docs.aws.amazon.com/codepipeline/latest/userguide/connections-github.html) in the AWS console
- Clone the repository
- Rename the repository folder to the application name:
- `mv aws-iac-fargate nodejs-express`
- `cd nodejs-express/fargate`
- `cd <MODULE>`
- Replace the AWS providers profile variable in the "`main.tf`" file located in each module:
    - See the how-to guide [here](./fargate/README.md)
- _Option 1_ - Add a "`terraform.tfvars`" file in each module directory and set the variables:
```sh
aws_region=
app_name=
app_port=
app_count=
...
```
- _Option 2_ - Set the default variables directly in the "`variables.tf`" file

### How to run the module:
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
