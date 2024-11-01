variable "aws_region" {
  default = "eu-west-2"
}

variable "app_name" {
    description = "Name of the app"
    default = "test-app"
}

variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default = 3000
}

variable "image_repo_name" {
  default = "nodejs-express"
}

variable "image_tag" {
  default = "latest"
}

variable "ecs_cluster_name" {
  default = "test-cluster"
}

variable "ecs_service_name" {
  default = "test-service"
}

variable "ecs_task_definition" {
  default = "test-app-task-family"
}

variable "codestarconnection_provider_type" {
  type = string
  default = "GitHub"
}

variable "repo_name" {
  default = "nodejs-express-server"
}

variable "repo_owner" {
  default = "ghost-goblin"
}

variable "repo_branch" {
  default = "main"
}

variable "s3_bucket_name" {
    type = string
    default = "test-app-s3-terraform-bucket-01"
}

variable "codebuild_project_name" {
    type = string
    default = "test-codebuild-project" 
}

variable "codepipeline_name" {
    type = string
    default = "test-codepipeline" 
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

variable "deployment_group_name" {
    type = string
    default = "test-deploy-group" 
}

variable "codedeploy_app_name" {
    type = string
    default = "test-codedeploy-app" 
}

variable "codedeploy_role" {
    type = string
    default = "test-codedeploy-role" 
}

variable "lb_target_group_green" {
    type = string
    default = "test-lb-green-3000" 
}

variable "lb_target_group_blue" {
    type = string
    default = "test-lb-blue-3000" 
}

variable "ecs_task_execution_role" {
    type = string
    default = "test-ecs-task-execution-role" 
}

variable "codestarconnection_arn" {
  type = string
  default = ""
}

variable "lb_listener_arn" {
    type = string
    default = "" 
}