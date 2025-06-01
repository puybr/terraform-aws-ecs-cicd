data "aws_iam_policy_document" "assume_by_codepipeline" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = var.codepipeline_role
  assume_role_policy = data.aws_iam_policy_document.assume_by_codepipeline.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    sid    = "s3Service"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject"
    ]

    resources = ["*"]
  }
  statement {
    sid    = "AllowPassRole"
    effect = "Allow"

    actions = [
      "iam:PassRole",
      "iam:GetRole"
    ]

    resources = ["*"]
  }
  statement {
    sid    = ""
    effect = "Allow"

    actions = ["codestar-connections:UseConnection"]

    resources = ["${var.codestar_connection_arn}"]
  }
  statement {
    sid    = "CodeBuild"
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]

    resources = ["*"]
  }
  statement {
    sid    = "ECS"
    effect = "Allow"

    actions = [
      "ecs:RegisterTaskDefinition"
    ]

    resources = ["*"]
  }
  statement {
    sid    = "CodeDeploy"
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  role   = aws_iam_role.codepipeline_role.name
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}
