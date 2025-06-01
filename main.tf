# Retrieve availability zones for the current region
data "aws_availability_zones" "available" {}

# Retreive current account ID
data "aws_caller_identity" "current" {}

# Retreive current region
data "aws_region" "current" {}

# Locals
locals {
  account_id = data.aws_caller_identity.current.account_id
}

# Create S3 bucket for codepipeline artifacts
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.app_name}-${uuid()}"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket     = aws_s3_bucket.codepipeline_bucket.id
  acl        = "private"
}

module "security" {
  source                       = "./modules/security"
  codebuild_role               = "codeBuildRole"
  codepipeline_role            = "codePipelineRole"
  codedeploy_role              = "codeDeployRole"
  ecs_task_execution_role_name = "ecsTaskExecutionRole"
}