# Locals
locals {
  account_id    = data.aws_caller_identity.current.account_id
  target_groups = ["blue", "green"]
}