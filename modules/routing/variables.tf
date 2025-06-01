variable "app_name" {
  description = "Name of the app"
  default     = "nodejs-express"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "health_check_path" {
  default = "/"
}

variable "load_balancer_name" {
  description = "Name of LB"
  default     = "lb-ecs"
}

variable "load_balancer_security_group_name" {
  default = "lb-sg"
}

variable "ecs_task_security_group_name" {
  default = "ecs-sg"
}