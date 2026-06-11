output "bucket" {
    value = aws_s3_bucket.default
    description = "The S3 Bucket resource"
}
output "bucket_name" {
  value       = aws_s3_bucket.default.id
  description = "The name of the S3 Bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.default.arn
  description = "The ARN identifying the S3 Bucket"
}

output "bucket_region" {
  value = aws_s3_bucket.default.region
  description = "The region the S3 Bucket is deployed in"
}

output "domain_name" {
  value = aws_s3_bucket.default.bucket_domain_name
  description = "The domain name of the S3 Bucket"
}

output "iam_policy_arn" {
  value = {
    "List"             = aws_iam_policy.list.arn
    "ListGet"          = aws_iam_policy.list_get.arn
    "ListGetPut"       = aws_iam_policy.list_get_put.arn
    "ListGetPutDelete" = aws_iam_policy.list_get_put_delete.arn
  }
}
