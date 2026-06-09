resource "aws_s3_bucket_object_lock_configuration" "default" {
  count      = var.enable_versioning && length(var.object_lock_retention_rules) > 0 ? 1 : 0
  bucket     = aws_s3_bucket.default.id
  depends_on = [aws_s3_bucket_versioning.default]

  rule {
    dynamic "default_retention" {
      for_each = var.object_lock_retention_rules
      content {
        mode = default_retention.value["mode"]
        days = default_retention.value["days"]
      }
    }
  }
}
