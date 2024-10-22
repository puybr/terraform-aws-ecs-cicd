# AWS CLI Setup
- Install and configure AWS CLI
- Optional - Create an additional AWS CLI profile:
- `nano ~/.aws/credentials`

```sh
[profile-name]
aws_access_key_id = XXXXXX
aws_secret_access_key = XXXXX
```
- `nano ~/.aws/config`

```
[profile-name]
region = eu-west-2
output = json
```
### Terraform Local Setup
Install Chocolatey
Install Terraform:
`choco install terraform`
Verify the installation:
`terraform -version`
Make a new module:
`mkdir my_terraform_module`
`cd my_terraform_module`
Add the AWS terraform providers "`terraform.tf`" file:
```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
 
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  profile = "profile-name"
}
```
Add the "`main.tf`" file:
```tf
# Retrieve availability zones for the current region
data "aws_availability_zones" "available" {}
 
# Retreive current account ID
data "aws_caller_identity" "current" {}
 
# Locals
locals {
    account_id = data.aws_caller_identity.current.account_id
}
```
Add the "`variable.tf`" file:
```tf
variable "aws_region" {
  description = "Default AWS region"
  type = string
  default = "eu-west-2"
}
 
variable "environment" {
  description = "Default environment: temp, test, trng, prod"
  type = string
  default = "temp"
}
 
variable "ecs_cluster_name" {
    description = "The ECS cluster name"
    type = string
    default = "ecs-docker"
}
```
Example - Create an ECS Cluster

Add an "`ecs.tf`" file:
```tf
resource "aws_ecs_cluster" "example" {
    name = "${var.environment}-${var.ecs_cluster_name}"
}
```
Check the Terraform Registry for more information about AWS resources!

Module Structure
```sh
$ tree
.
|-- ecs.tf
|-- main.tf
|-- terraform.tf
`-- variables.tf
```
### Initialize and plan the module
Initialize the Terrform module in the root module directory:
`terraform init`
Validate the configuration files:
`terraform validate`
Plan the changes:
`terraform plan`
Override default variables
Option 1: Add a "`terraform.tfvars`" file to override multiple default variables:
```tf
environment="test"
```
Option 2: Override specific variables in the CLI:
```tf
$ terraform plan -var environment="test"
```
Apply the module
`terraform apply`
`terraform apply -var environment="test"`
Destroy the module
`terraform destroy`

### Terraform Variables
- Terraform will automatically load any files with "`*.auto.tfvars`" and "`terraform.tfvars`"
- The "`variable.tf`" file needs to have all the variables declared which can have a default value or not
- The "`.tfvars`" file is one way of associating variables to an environment
Conditionally assign values to different parameters based on the variables:
```tf
instance_type = var.environment == "prod" ? "t2.macro" : "t2.nano"
```
### Managing variables with Terraform
- For each environment, create a "tfvars" file:
```sh
test.tfvars
trng.tfvars
prod.tfvars
```
- Based on the environment, run apply using the variable file:
```sh
$ terraform apply -var-file="test.tfvars"
```
### Terraform State
Terraform uses state data to remember which object corresponds to each resource in the configuration
The state is stored in the default "`terraform.tfstate`" file
List the local Terraform state:
```sh
$ terraform state list
aws_alb.main
aws_alb_listener.http_front_end
aws_alb_listener.https_front_end
aws_alb_target_group.blue["0"]
aws_alb_target_group.green["0"]
aws_lb_listener_rule.host_based_weighted_routing["0"]
aws_security_group.lb
```
The remote Terraform state is stored in the S3 bucket backend
The DynamoDB table supports state locking, consistency checking and can configure multiple remote state files
Add the backend config to the "terraform.tf" providers file:
```tf
# terraform {
    backend "s3" {
    bucket             = "components-tfstate"
    key                = "state/terraform.tfstate"
    region             = "eu-west-2"
    dynamodb_table     = "components_tf_lockid"
    encrypt            = true
    profile            = "profile-name"
    }
# }
```
Migrate the Terraform state file from one backend to another:
terraform init -migrate-state
Terraform Workspaces
Terraform starts with a single "`default`" workspace that cannot be deleted:
```sh
$ terraform workspace list
* default
```
- Workspaces manage multiple deployments of the same configuration such as different environments
- Terraform does not access existing resources in other workspaces, allowing multiple states to be associated with a single configuration
- Add a new workspace
```sh
terraform workspace new test
```
Verify the setup:
terraform workspace show
Run "`terraform plan`" to initialize the new workspace
Terraform workspaces and state file
Terraform creates a corresponding new state file in the same remote backend for the new workspace
A new "`env:/`" directory is created along with the subdirectory of the workspace (test, trng, prod)
The "`terraform.tfstate`" file is maintained at this location:
```sh
env:/test/terraform.tfstate
env:/trng/terraform.tfstate
env:/prod/terraform.tfstate
```
Delete a workspace
```sh
$ terraform workspace select default
Switched to workspace "default".
 
$ terraform workspace delete test
Deleted workspace "test"!
```
