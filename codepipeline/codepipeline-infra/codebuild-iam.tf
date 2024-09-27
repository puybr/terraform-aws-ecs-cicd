resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "TrustPolicyStatementThatAllowsEC2ServiceToAssumeTheAttachedRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = var.codebuild_policy
  role = aws_iam_role.codebuild_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.bucket}/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:GetAuthorizationToken",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ],
      "Resource": [
        "*"
      ],
        "Effect": "Allow"
    },
    {
      "Action": [
        "ecs:UpdateService",
        "ecs:DescribeTaskDefinition",
        "iam:GetRole",
        "iam:PassRole"
      ],
      "Resource": [
        "*"
      ],
        "Effect": "Allow"
    }
  ]
}
EOF
}