resource "aws_codebuild_project" "codebuild_project_build_stage" {
  name          = var.codebuild_project_name
  description   = "Build Stage for CodePipeline"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "${local.account_id}"
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }
    environment_variable {
      name  = "APPLICATION_NAME"
      value = var.app_name
    }
    environment_variable {
      name  = "APPLICATION_PORT"
      value = var.app_port
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo_name
    }
    environment_variable {
      name  = "IMAGE_TAG"
      value = var.image_tag
    }
    environment_variable {
      name  = "TASK_DEFINITION"
      value = var.ecs_task_definition
    }
    environment_variable {
      name  = "TASK_DEFINITION_ARN"
      value = "arn:aws:ecs:${var.aws_region}:${local.account_id}:task-definition/${var.ecs_task_definition}"
    }
  }
  source {
     type   = "CODEPIPELINE"
  }
}