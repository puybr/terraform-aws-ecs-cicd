# 🚜 AWS ECS and CodePipeline Infrastructure-as-Code


### Terraform Modules:
1. [app](./modules/app)
2. [cicd](./modules/cicd)
3. [network](./modules/network)
4. [repo](./modules/repo)
5. [routing](./modules/routing)
6. [security](./modules/security)

> ✏️ Check out the tutorial [here](./modules/README.md)

### How to setup:
- Create the IAM user and apply the required permissions
- Generate the AWS CLI access keys in the IAM console or Identity Center (SSO)
- Install and configure the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Configure the [Codestar Connection](https://docs.aws.amazon.com/codepipeline/latest/userguide/connections-github.html)
- Clone this repository
- Fork the `nodejs-express-aws-boilerplate` repository



#### Modify the AWS provider block
- Located in the "`main.tf`" file in each module
- Configure an additional AWS CLI profile:
- `aws configure --profile profile-name`
- `aws configure sso --profile profile-name`
```sh
# provider "aws" {
    profile = "profile-name"   <--- optional
# }
```
- Or use the `[default]` AWS CLI profile

#### Set the variables
- _Option 1_ - Add a "`terraform.tfvars`" file in each module directory
- _Option 2_ - Set the default variables directly in the module block in the "`main.tf`" file


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
- [ ] Add a root module and connect the child  module outputs in [module blocks](https://developer.hashicorp.com/terraform/language/modules/syntax)
- [ ] Configure [default tags](https://developer.hashicorp.com/terraform/tutorials/aws/aws-default-tags) for AWS resources
- [ ] _Optional:_ _[Refactor the monolithic Terraform configuration](https://developer.hashicorp.com/terraform/tutorials/modules/organize-configuration) into environments_
- [ ] Migrate the local `terraform.tfstate` to a [remote S3 backend](https://developer.hashicorp.com/terraform/language/backend/s3)
- [ ] Configure CI/CD for Terraform using the [hashicorp/terraform](https://gallery.ecr.aws/hashicorp/terraform) prebuilt image (one-click deployments)
- [ ] Lock the [provider version](https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning)
