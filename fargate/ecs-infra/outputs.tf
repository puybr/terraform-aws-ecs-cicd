output "lb_hostname" {
  value = "${aws_alb.main.dns_name}:${var.app_port}"
}

output "lb_listener_arn" {
  value = aws_alb_listener.front_end.arn
}

 output "lb_target_group_names" {
    value = aws_alb_target_group.app[*].name
 }

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}

output "aws_ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "aws_ecs_service_name" {
  value = aws_ecs_service.main.name
}