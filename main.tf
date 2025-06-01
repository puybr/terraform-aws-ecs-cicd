resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.app_name}-${uuid()}"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket     = aws_s3_bucket.codepipeline_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}