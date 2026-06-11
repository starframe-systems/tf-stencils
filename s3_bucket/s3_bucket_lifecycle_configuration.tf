
resource "aws_s3_bucket_lifecycle_configuration" "default" {
  count  = var.lifecycle_enabled ? 1 : 0
  bucket = aws_s3_bucket.default.id

  dynamic "rule" {
    for_each = var.bucket_enable_intelligent_tiering ? [1] : []
    content {
      id     = "transition-to-intelligent-tiering"
      status = "Enabled"

      transition {
        days          = 0
        storage_class = "INTELLIGENT_TIERING"
      }
    }
  }

  dynamic "rule" {
    for_each = var.bucket_enable_ttl ? [1] : []
    content {
      id     = "expiration"
      status = "Enabled"

      expiration {
        days = var.bucket_ttl_days
      }
    }
  }
  
}
