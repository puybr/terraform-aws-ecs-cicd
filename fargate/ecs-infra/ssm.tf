resource "aws_ssm_parameter" "app" {
  name  = var.app_name
  type  = "String"
  value = "secret"
}