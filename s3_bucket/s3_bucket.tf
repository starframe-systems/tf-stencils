
resource "aws_s3_bucket" "default" {
  bucket        = var.name
  tags          = merge(local.resource_tags, { Name = var.name })
  force_destroy = var.force_destroy
}

# resource "aws_s3_bucket_policy" "default" {
#   bucket = aws_s3_bucket.default.id
#   policy = data.aws_iam_policy_document.default.json
# }
