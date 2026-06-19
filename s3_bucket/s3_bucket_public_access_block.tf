
resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.default.id
  block_public_acls       = lookup(var.bucket_public_access, "block_public_acls")
  block_public_policy     = lookup(var.bucket_public_access, "block_public_policy")
  ignore_public_acls      = lookup(var.bucket_public_access, "ignore_public_acls")
  restrict_public_buckets = lookup(var.bucket_public_access, "restrict_public_buckets")
}
