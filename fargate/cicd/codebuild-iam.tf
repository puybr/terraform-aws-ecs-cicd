data "aws_iam_policy_document" "assume_by_codebuild" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild_role" {
  name               = var.codebuild_role
  assume_role_policy = data.aws_iam_policy_document.assume_by_codebuild.json
}


data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }
  statement {
    sid    = ""
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
    sid    = ""
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = ["*"]
  }
statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "codeartifact:GetAuthorizationToken",
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ReadFromRepository",
      "codeartifact:PublishPackageVersion",
      "codeartifact:PutPackageMetadata"
    ]

    resources = ["*"]
  }
  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "sts:GetServiceBearerToken"
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "sts:AWSServiceName"
      values   = ["codeartifact.amazonaws.com"]
    }
    resources = ["*"]
  }
statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "secretsmanager:DescribeSecret"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  role   = aws_iam_role.codebuild_role.name
  policy = data.aws_iam_policy_document.codebuild_policy.json
}
