
output "website_domain" {
  description = "Domain of the website endpoint. This is used to create Route 53 alias records."
  value       = aws_s3_bucket_website_configuration.default.website_domain
}

output "website_endpoint" {
  description = "URL of the website endpoint. This is used to access the website."
  value       = aws_s3_bucket_website_configuration.default.website_endpoint
}
