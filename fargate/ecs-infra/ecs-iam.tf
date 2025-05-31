data "aws_iam_policy_document" "assume_by_ecs" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_by_ecs.json
}

data "aws_iam_policy_document" "ecs_policy" {
  statement {
    sid    = "SSMParameterStore"
    effect = "Allow"

    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameters"
    ]

    resources = ["*"]
  }
  statement {
    sid    = "SecretsManager"
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]

    resources = ["*"]
  }
  statement {
    sid    = "Decryption"
    effect = "Allow"

    actions = [
      "kms:Decrypt"
    ]

    resources = ["*"]
  }
  statement {
    sid    = "Logs"
    effect = "Allow"

    actions = [
      "logs:*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ecs_policy" {
  role   = aws_iam_role.ecs_task_execution_role.name
  policy = data.aws_iam_policy_document.ecs_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}