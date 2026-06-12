output "domain_name" {
  description = "The domain name of the CloudFront distribution. This is used to create Route 53 alias records."
  value       = aws_cloudfront_distribution.default.domain_name
}

output "iam_policy_arn" {
  value = {
    CreateInvalidation = aws_iam_policy.CreateInvalidation.arn
  }
}
