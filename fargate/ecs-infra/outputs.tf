output "lb_hostname" {
  value = "${aws_alb.main.dns_name}:${var.app_port}"
}

output "lb_listener_arn" {
  value = aws_alb_listener.front_end.arn
}
