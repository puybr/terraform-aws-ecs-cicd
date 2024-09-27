variable "aws_region" {
  default = "eu-west-2"
}

variable "az_count" {
    description = "Number of AZs to cover in a given region"
    default = "2"
}

variable "image_repo_name" {
  default = "nodejs-express"
}

variable "image_tag" {
  default = "latest"
}

variable "app_name" {
    description = "Name of the app"
    default = "test-app"
}

variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default = 3000
}

variable "app_count" {
    description = "Number of docker containers to run"
    default = 2
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
    default = "test-lb"
}

variable "ecs_task_execution_role_name" {
    description = "ECS task execution role name"
    default = "test-ecs-task-execution-role"
}

variable "ecs_task_execution_policy_name" {
    description = "ECS task execution policy name"
    default = "test-ecs-task-execution-policy"
}

variable "load_balancer_security_group_name" {
    default = "test-load-balancer-security-group"
}

variable "ecs_task_security_group_name" {
    default = "test-ecs-task-security-group"
}

variable "ecs_service_name" {
    default = "test-service"
}

variable "ecs_cluster_name" {
    default = "test-cluster"
}

variable "template_file_path" {
    default = "./templates/task-definition.json.tpl"
}