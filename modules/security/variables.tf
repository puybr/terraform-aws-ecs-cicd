variable "codebuild_role" {
  type    = string
  default = "codeBuildRole"
}

variable "codepipeline_role" {
  type    = string
  default = "codePipelineRole"
}

variable "codedeploy_role" {
  type    = string
  default = "codeDeployRole"
}

variable "ecs_task_execution_role_name" {
  type    = string
  default = "ecsTaskExecutionRole"
}