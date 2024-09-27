# Retrieve availability zones for the current region
data "aws_availability_zones" "available" {}

# Retreive current account ID
data "aws_caller_identity" "current" {}

# Locals
locals {
    account_id = data.aws_caller_identity.current.account_id
    target_groups = [ "green", "blue" ]
}