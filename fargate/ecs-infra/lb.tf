# Create the Application Load Balancer
resource "aws_alb" "main" {
    name            = var.load_balancer_name
    subnets         = aws_subnet.public.*.id
    security_groups = [aws_security_group.lb.id]
}

# Create the Target Groups
resource "aws_alb_target_group" "app" {
    count       = "${length(local.target_groups)}"
    name        = "${var.load_balancer_name}-${element(local.target_groups, count.index)}-${var.app_port}"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.main.id
    target_type = "ip"

    health_check {
        healthy_threshold   = "3"
        interval            = "30"
        protocol            = "HTTP"
        matcher             = "200"
        timeout             = "3"
        path                = var.health_check_path
        unhealthy_threshold = "2"
    }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.0.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_alb_listener.front_end.arn
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.0.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}