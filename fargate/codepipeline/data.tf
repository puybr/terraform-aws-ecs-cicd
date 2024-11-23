# Retrieve availability zones for the current region
data "aws_availability_zones" "available" {}

# Retreive current account ID
data "aws_caller_identity" "current" {}

# Retreive current region
data "aws_region" "current" {}