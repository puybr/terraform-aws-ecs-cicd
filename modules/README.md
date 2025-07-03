# AWS Terraform

### AWS CLI Setup
#### _Option 1_ - Add the AWS access secret keys directly to the provider block:
```sh
# provider "aws" {
    access_key = "*****"
    secret_key = "*****"
# }
```

#### _Option 2_ - Set the AWS environment variables in the terminal and omit the profile value from the provider:
```sh
export AWS_ACCESS_KEY_ID=*****
export AWS_SECRET_ACCESS_KEY=*****
export AWS_SESSION_TOKEN=*****
```

#### _Option 3_ - Configure a new AWS CLI profile:
- `aws configure --profile <profile-name>`
```sh
# ~/.aws/credentials
[profile-name]
aws_access_key_id = [*****]
aws_secret_access_key = [*****]
```
```sh
# ~/.aws/config
[profile profile-name]
region = eu-west-2
output = json
```

#### _Option 4_ - Configure a new profile with [IAM Identity Center](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#sso-configure-profile-token-auto-sso) authentication (SSO):
- `aws configure sso --profile <profile-name>`
```sh
# ~/.aws/config
[profile profile-name]
sso_session = test-sso
sso_account_id = 444455556666
sso_role_name = roleName
region = eu-west-2
output = json
[sso-session test-sso]
sso_region = eu-west-2
sso_start_url = https://my-sso-portal.awsapps.com/start
sso_registration_scopes = sso:account:access
```
- `aws sso login --profile <profile-name>`
- `aws sso logout --profile <profile-name>`

##### Add the profile value to the provider block:
```sh
# provider "aws" {
    profile = "profile-name"
# }
```
##### Run `aws configure list-profiles`

#### _Option 5_ -  Use the `[default]` profile and omit the profile value from the provider

##### Run `aws sts get-caller-identity --profile <profile-name>` to return details about the IAM user or role whose credentials are used to call the operation

##### Run `terraform init -reconfigure` to reconfigure Terraform when switching to different AWS CLI profiles

### Terraform Local Setup
- Install [Chocolatey](https://chocolatey.org/install)
- Install Terraform:
`choco install terraform`
- Verify the installation:
`terraform -version`

#### _Example_ - Create a monolithic module
- `mkdir ecs-infra && cd ecs-infra`
- Create the "`main.tf`" file in the "`ecs-infra`" directory
- Add the required AWS terraform providers block to the "`main.tf`" file:
```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```
Add the provider block to the "`main.tf`" file:
```tf
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  profile = "profile-name"   <--- optional
  default_tags {
    tags = {
      Terraform = "true"
      ...
    }
  }
}
```
Create the "`variables.tf`" file:
```tf
variable "aws_region" {
    description = "Default AWS region"
    type = string
    default = "eu-west-2"
}
 
variable "environment" {
    description = "Default environment: dev, stag, prod"
    type = string
    default = "dev"
}
 
variable "ecs_cluster_name" {
    description = "The ECS cluster name"
    type = string
    default = "ecs-docker"
}
```

Create the "`ecs.tf`" file:
```tf
# Create ECS cluster
resource "aws_ecs_cluster" "example" {
    name = "${var.environment}-${var.ecs_cluster_name}"
}
```

> Check the [Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest) for more information about AWS resources!

Monolithic Module Structure:
```sh
$ tree
.
├── ecs.tf
├── main.tf
├── terraform.tfstate
├── terraform.tfvars
└── variables.tf
```

### Module Development
- Module creation - [recommended pattern](https://developer.hashicorp.com/terraform/tutorials/modules/pattern-module-creation)
- [Standard module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
- [Module composition](https://developer.hashicorp.com/terraform/language/modules/develop/composition)

[Module Blocks](https://developer.hashicorp.com/terraform/language/modules/syntax):
- Add a module block to the "`main.tf`" file in the root module:
```sh
# Module Blocks
module "ecs-infra" {
  source      = "../ecs-infra"
  environment = var.environment
}

module "backend" {
  source = "../backend"
  backend = {
    bucket                = "terraform-tfstate"
    create_dynamodb_table = false
    dynamodb_table        = null
  }
}

# Outputs
output "aws_s3_bucket" {
  description = "Backend state bucket"
  value       = module.backend.aws_s3_bucket
}

output "lb_listener_arn" {
  description = "ARN of the LB listener"
  value       = module.ecs-infra.lb_listener_arn
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources):
- A data block requests that Terraform read from a given data source and exports the result under the given local name:
```sh
# Get listener from load_balancer_arn and port
data "aws_lb" "selected" {
  name = "default-public"
}

data "aws_lb_listener" "selected443" {
  load_balancer_arn = data.aws_lb.selected.arn
  port              = 443
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals):
- A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression:
```sh
# Retrieve the current region
data "aws_region" "current" {}

# Retreive current account ID
data "aws_caller_identity" "current" {}

# Locals
locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}
```

### Manage multiple environments
1. Terraform Workspaces
2. [Terragrunt](https://terragrunt.gruntwork.io/) (_3rd party thin wrapper on top of Terraform_)
3. [Separate modules in a directory structure](https://developer.hashicorp.com/terraform/tutorials/modules/organize-configuration) (_one Git branch_)
4. Git branch per environment

Separate Module Structure:
```
$ tree
.
├── ecs-infra
│   ├── ecs.tf
│   ├── variables.tf
├── prod
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfstate
│   └── terraform.tfvars
└── dev
    ├── main.tf
    ├── variables.tf
    ├── terraform.tfstate
    └── terraform.tfvars
```

### Initialize and plan the module
- Initialize the Terrform module in the root module directory:
`terraform init`
- Rewrite configuration files to a canonical format and style: `terraform fmt [-recursive]`
- Validate the configuration files:
`terraform validate`
- Plan the changes:
`terraform plan`

### Override default variables
- _Option 1_: Add a "`terraform.tfvars`" file to override multiple default variables:
```tf
environment="dev"
```
- _Option 2_: Override specific variables in the CLI:
```tf
terraform plan -var environment="dev"
```


### Apply the module
- `terraform apply`
- `terraform apply -var environment="dev"`


### Destroy the module
- `terraform destroy`


## Terraform Variables
- Terraform will automatically load any files with "`*.auto.tfvars`" and "`terraform.tfvars`"
- The "`variables.tf`" file needs to have all the variables declared which can have a default value or not
- The "`.tfvars`" file is one way of associating variables to an environment
- Conditionally assign values to different parameters based on the variables:
```tf
desired_count = var.environment == "prod" ? 2 : 1
```

### Managing variables with Terraform
- For each environment, create a "`.tfvars`" file:
```sh
dev.tfvars
stag.tfvars
prod.tfvars
```
- Based on the environment, run apply using the variable file:
```sh
terraform apply -var-file="dev.tfvars"
```

## Terraform State
- Terraform uses state data to remember which object corresponds to each resource in the configuration
- The state is stored in the default "`terraform.tfstate`" file
- List the Terraform state:
```sh
terraform state list
```
- [Show](https://developer.hashicorp.com/terraform/cli/commands/state/show) the Terraform state:
```sh
terraform state show 'module.ecs.aws_ecs_service.example[\"<app>\"]'
```
- The remote Terraform state is stored in the [S3 bucket backend](https://developer.hashicorp.com/terraform/language/backend/s3)
- The DynamoDB table supports state locking, consistency checking and can configure multiple remote state files
- Add the backend configuration to the `terraform` block:
```tf
# terraform {
    backend "s3" {
    bucket             = "components-tfstate"
    key                = "state/components.tfstate"
    region             = "eu-west-2"
    dynamodb_table     = "components_tf_lockid"
    encrypt            = true
    profile            = "profile-name"   <--- optional
    }
# }
```

### State Manipulation
- Pull the remote state: `terraform state pull`
- Make a backup of the state file
- Copy the state over to the new location
- Migrate the Terraform state file from one backend to another:
`terraform init -migrate-state`
- [Remove](https://developer.hashicorp.com/terraform/cli/commands/state/rm) remote state objects: `terraform state rm`
- Double check the state: `terraform state list`!!!
- After confirming the state list is correct, run `terraform plan` to make sure there are no infrastructure changes
- [Move/rename](https://developer.hashicorp.com/terraform/cli/commands/state/mv) the Terraform state: `terraform state mv`
    - `terraform state mv -dry-run module.ecs module.network`
    - Bulk move/rename:
        ```sh
        #!/bin/bash
        set -eo pipefail
        
        source=$1
        dest=$2
        
        terraform state mv module.ecs.aws_ecs_service.example[\"$1\"] module.ecs.aws_ecs_service.example[\"$2\"]
        ```
- [Import](https://developer.hashicorp.com/terraform/cli/import) existing resources:
   - ```sh
     terraform import module.network.aws_ecs_cluster.main test-ecs-cluster
     ```

## Terraform Workspaces
- Terraform starts with a single "`default`" workspace that cannot be deleted:
```sh
$ terraform workspace list
* default
```
- Workspaces manage multiple deployments of the same configuration such as different environments
- Terraform does not access existing resources in other workspaces, allowing multiple states to be associated with a single configuration
- Add a new workspace:
```sh
terraform workspace new dev
```
- Verify the setup:
```sh
terraform workspace show
```
- Run "`terraform plan`" to initialize the new workspace
- Terraform workspaces and state file
Terraform creates a corresponding new state file in the same remote backend for the new workspace
- A new "`env:/`" directory is created along with the subdirectory of the workspace
- The "`terraform.tfstate`" file is maintained at this location:
```sh
env:/dev/terraform.tfstate
env:/stag/terraform.tfstate
env:/prod/terraform.tfstate
```
- Delete a workspace:
```sh
$ terraform workspace select default
Switched to workspace "default".
 
$ terraform workspace delete dev
Deleted workspace "dev"!
```

