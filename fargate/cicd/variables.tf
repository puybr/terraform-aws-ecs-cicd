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

variable "ecs_cluster_name" {
  default = "ecs-docker"
}

variable "repo_name" {
  default = "nodejs-express-boilerplate"
}

variable "repo_owner" {
  default = "puybr"
}

variable "repo_branch" {
  default = "temp"
}

variable "codebuild_role" {
    type = string
    default = "codeBuildRole" 
}

variable "codepipeline_role" {
    type = string
    default = "codePipelineRole" 
}

variable "codedeploy_role" {
    type = string
    default = "codeDeployRole" 
}

variable "ecs_task_execution_role" {
    type = string
    default = "ecsTaskExecutionRole"
}

variable "codestar_connection_arn" {
  type = string
  default = ""
}

variable "lb_listener_arn" {
    type = string
    default = "" 
}
