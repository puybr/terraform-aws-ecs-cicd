variable "aws_region" {
  default = "eu-west-2"
}

variable "az_count" {
  default = 1
}

variable "app_name" {
    description = "Name of the app"
    default = "nodejs-express"
}

variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default = 3000
}

variable "app_count" {
    description = "Number of docker containers to run"
    default = 1
}

variable "image_tag" {
  default = "latest"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
    description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
    default = 256
}

variable "fargate_memory" {
    description = "Fargate instance memory to provision (in MiB)"
    default = 512
}

variable "load_balancer_name" {
    description = "Name of LB"
    default = "lb-ecs"
}

variable "ecs_task_execution_role_name" {
    description = "ECS task execution role name"
    default = "ecsTaskExecutionRole"
}

variable "load_balancer_security_group_name" {
    default = "lb-sg"
}

variable "ecs_task_security_group_name" {
    default = "ecs-sg"
}

variable "ecs_cluster_name" {
    default = "ecs-docker"
}
