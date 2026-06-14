
resource "aws_acm_certificate" "default" {
  provider                  = aws.acm_provider
  domain_name               = var.distribution_domain_name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.resource_tags
}

resource "aws_acm_certificate_validation" "default" {
  provider        = aws.acm_provider
  certificate_arn = aws_acm_certificate.default.arn
  
  validation_record_fqdns = [
    for record in aws_route53_record.domain-validation : record.fqdn
  ]
}
