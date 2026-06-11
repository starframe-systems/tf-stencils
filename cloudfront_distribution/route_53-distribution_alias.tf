
resource "aws_route53_record" "distrinbution-alias" {
  zone_id = var.route53_zone_id
  name    = var.distribution_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.default.domain_name
    zone_id                = aws_cloudfront_distribution.default.hosted_zone_id
    evaluate_target_health = false
  }

  allow_overwrite = true
}
