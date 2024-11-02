resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.repo_name
  image_tag_mutability = "MUTABLE"
}

data "aws_iam_policy_document" "example" {
  statement {
    sid    = "${var.repo_name}-policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "ecr:*"
    ]
  }
}

resource "aws_ecr_repository_policy" "example" {
  repository = aws_ecr_repository.ecr_repository.name
  policy     = data.aws_iam_policy_document.example.json
}