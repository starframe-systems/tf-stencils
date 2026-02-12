locals {
  custom_cname                  = "${var.custom_cname_hostname}.${var.custom_cname_domain}"
  api_gateway_stage_invoke_fqdn = element(split("/", aws_api_gateway_stage.this.invoke_url), 2)
}
resource "aws_acm_certificate" "this" {
  count             = var.enable_custom_cname && var.enable_custom_cname_creation ? 1 : 0
  domain_name       = local.custom_cname
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "custom_cname_acm_cert_validation" {
  count           = var.enable_custom_cname && var.enable_custom_cname_creation ? 1 : 0
  name            = tolist(aws_acm_certificate.this[0].domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.this[0].domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.this[0].domain_validation_options)[0].resource_record_type
  ttl             = 60
  zone_id         = var.custom_cname_route53_zone_id
  allow_overwrite = true
}
resource "aws_acm_certificate_validation" "this" {
  count                   = var.enable_custom_cname && var.enable_custom_cname_creation ? 1 : 0
  certificate_arn         = aws_acm_certificate.this[0].arn
  validation_record_fqdns = [aws_route53_record.custom_cname_acm_cert_validation[0].fqdn]
}
resource "aws_api_gateway_domain_name" "this" {
  count                    = var.enable_custom_cname && var.enable_custom_cname_creation ? 1 : 0
  domain_name              = aws_acm_certificate.this[0].domain_name
  regional_certificate_arn = aws_acm_certificate.this[0].arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = module.tags.combined_tags
}
resource "aws_api_gateway_base_path_mapping" "this" {
  count       = var.enable_custom_cname ? 1 : 0
  api_id      = aws_api_gateway_rest_api.this.id
  domain_name = var.enable_custom_cname_creation ? aws_api_gateway_domain_name.this[0].domain_name : "${var.custom_cname_hostname}.${var.custom_cname_domain}"
  stage_name  = aws_api_gateway_stage.this.stage_name
  base_path   = var.custom_cname_base_path_map
}
resource "aws_route53_record" "custom_cname" {
  count   = var.enable_custom_cname && var.enable_custom_cname_creation ? 1 : 0
  name    = aws_api_gateway_domain_name.this[0].domain_name
  type    = "A"
  zone_id = var.custom_cname_route53_zone_id
  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.this[0].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.this[0].regional_zone_id
  }
}
