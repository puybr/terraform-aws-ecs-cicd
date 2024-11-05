# 🚜 AWS Docker Infrastructure


### Terraform Modules:
1. [ecr-infra](./fargate/ecr-infra)
2. [ecs-infra](./fargate/ecs-infra)
3. [codepipeline](./fargate/codepipeline)

> See the how-to guide [here](./fargate/README.md)

### How to setup:
- Create the IAM user and apply the required permissions for the role
- Generate the AWS CLI access keys in the IAM console
- Install and configure the AWS CLI
- Configure the [Codestar Connection](https://docs.aws.amazon.com/codepipeline/latest/userguide/connections-github.html)
- Clone the repository
- Rename the repository folder to the application name: `mv aws-iac-fargate <APP_NAME>`
- `cd <APP_NAME>/fargate/<MODULE>/`



#### Configure the AWS provider block
- Located in the "`main.tf`" file in each module
- _Option 1_ - Add the AWS access key and secret key:
```sh
# provider "aws" {
    access_key = "*****"
    secret_key = "*****"
# }
```
- _Option 2_ - Configure an additional AWS CLI profile:
```sh
# provider "aws" {
    profile = "profile-name"
# }
```
- _Option 3_ - Export the keys and omit the values from the provider:
```sh
export AWS_ACCESS_KEY_ID=*****
export AWS_SECRET_ACCESS_KEY=*****
```


#### Set the variables
- _Option 1_ - Add a "`terraform.tfvars`" file in each module directory:
```sh
aws_region="eu-west-2"
app_name="nodejs-express"
app_port=3000
app_count=1
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
