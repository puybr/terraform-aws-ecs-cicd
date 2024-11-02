variable "aws_region" {
  default = "eu-west-2"
}

variable "app_name" {
    description = "Name of the app"
    default = "nodejs-express"
}

variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default = 3000
}

variable "image_tag" {
  default = "latest"
}

variable "ecs_cluster_name" {
  default = "ecs-docker"
}

variable "codestarconnection_provider_type" {
  type = string
  default = "GitHub"
}

variable "repo_name" {
  default = "nodejs-express-server"
}

variable "repo_owner" {
  default = "puybr"
}

variable "repo_branch" {
  default = "temp"
}

variable "s3_bucket_name" {
    type = string
    default = "test-app-s3-terraform-bucket-01"
}

variable "codebuild_role" {
    type = string
    default = "test-app-codebuild-role" 
}

variable "codebuild_policy" {
    type = string
    default = "test-app-codebuild-policy" 
}

variable "codepipeline_role" {
    type = string
    default = "test-app-codepipeline-role" 
}

variable "codepipeline_policy" {
    type = string
    default = "test-app-codepipeline-policy" 
}

variable "codedeploy_role" {
    type = string
    default = "test-codedeploy-role" 
}

variable "ecs_task_execution_role" {
    type = string
    default = "ecsTaskExecutionRole"
}

variable "codestarconnection_arn" {
  type = string
  default = ""
}

variable "lb_listener_arn" {
    type = string
    default = "" 
}
