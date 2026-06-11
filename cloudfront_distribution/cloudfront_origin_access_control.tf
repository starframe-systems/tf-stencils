
resource "aws_cloudfront_origin_access_control" "default" {
  count = var.bucket_name != null ? 1 : 0
  
  name                              = var.bucket_name
  description                       = "S3 bucket access control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
