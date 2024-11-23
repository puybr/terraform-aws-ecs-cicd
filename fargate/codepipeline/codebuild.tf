resource "aws_codebuild_project" "codebuild_project_build_stage" {
  name         = var.app_name
  description  = "Build Stage for CodePipeline"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = local.account_id
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }
    environment_variable {
      name  = "APPLICATION_NAME"
      value = var.app_name
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "infrastructure/buildspec.yml"
  }
}
