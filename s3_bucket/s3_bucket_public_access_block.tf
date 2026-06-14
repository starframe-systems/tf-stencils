
resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.default.id
  block_public_acls       = lookup(var.bucket_public_access, "block_public_acls", true)
  block_public_policy     = lookup(var.bucket_public_access, "block_public_policy", true)
  ignore_public_acls      = lookup(var.bucket_public_access, "ignore_public_acls", true)
  restrict_public_buckets = lookup(var.bucket_public_access, "restrict_public_buckets", true)
}
