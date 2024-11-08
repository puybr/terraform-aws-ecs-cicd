# 🚜 AWS Docker Infrastructure


### Terraform Modules:
1. [ecr-infra](./fargate/ecr-infra)
2. [ecs-infra](./fargate/ecs-infra)
3. [cicd](./fargate/cicd)

> ✏️ Check the tutorial [here](./fargate/README.md)

### How to setup:
- Create the IAM user and apply the required permissions
- Generate the AWS CLI access keys in the IAM console or Identity Center (SSO)
- Install and configure the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Configure the [Codestar Connection](https://docs.aws.amazon.com/codepipeline/latest/userguide/connections-github.html)
- Clone this repository
- Fork the `nodejs-express-boilerplate` application repository



#### Modify the AWS provider block
- Located in the "`main.tf`" file in each module
- _Option 1_ - Configure an additional AWS CLI profile: `aws configure --profile profile-name` `aws configure sso --profile profile-name`
```sh
# provider "aws" {
    profile = "profile-name"
# }
```
- _Option 2_ - Set the AWS environment variables in the terminal and omit the profile value from the provider:
```sh
export AWS_ACCESS_KEY_ID=*****
export AWS_SECRET_ACCESS_KEY=*****
export AWS_SESSION_TOKEN=*****
```


#### Set the variables
- _Option 1_ - Add a "`terraform.tfvars`" file in each module directory
- _Option 2_ - Set the default variables directly in the "`variables.tf`" file


### 🚀 How to run the module:
```sh
terraform init
terraform plan
terraform apply
```

### ☁️ AWS Resources:
- [x] **Virtual Private Cloud** (VPC)
    - Subnets
    - Internet Gateway
    - Route Tables
    - NAT Gateway
- [x] **Application Load Balancer** (ALB)
    - ALB HTTP Listener
    - ALB Listener Rules
    - Target Groups
    - Target Group Health Checks
- [x] **IAM Roles & Policies**
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

### ✅️ To-do
- [ ] Add a root module and connect the child  module outputs in module blocks
- [ ] Refactor the monolithic Terraform configuration into environments
- [ ] Migrate the local state to a remote S3 backend
- [ ] Terraform CI/CD (one-click deployments)
- [ ] Lock the [provider version](https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning)
