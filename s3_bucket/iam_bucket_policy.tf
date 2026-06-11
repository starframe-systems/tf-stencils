# This file defines the S3 bucket policy resource, which attaches a policy to
# the S3 bucket if a policy JSON is provided.

resource "aws_s3_bucket_policy" "provided" {
  count  = var.bucket_policy_json != null ? 1 : 0
  bucket = aws_s3_bucket.default.id
  policy = var.bucket_policy_json
}
