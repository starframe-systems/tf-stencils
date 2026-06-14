
resource "aws_cloudfront_distribution" "default" {
  dynamic "origin" {
    for_each = var.bucket_name != null ? [1] : []

    content {
      domain_name = var.bucket_name
      origin_id   = var.distribution_domain_name
      origin_access_control_id = aws_cloudfront_origin_access_control.default[0].id
    }
  }

  dynamic "origin" {
    for_each = var.origin_domain_name != null ? [1] : []

    content {
      domain_name = var.origin_domain_name
      origin_id   = var.distribution_domain_name

      custom_origin_config {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  aliases = [var.distribution_domain_name]

  default_cache_behavior {
    target_origin_id = var.distribution_domain_name
    allowed_methods = [
      "GET",
      "HEAD",
    ]
    cached_methods = [
      "GET",
      "HEAD"
    ]
    cache_policy_id        = aws_cloudfront_cache_policy.default.id
    viewer_protocol_policy = "redirect-to-https"
    compress               = false
  }

  default_root_object = "index.html"

  custom_error_response {
    error_code            = 403
    response_code         = 403
    response_page_path    = "/index.html"
    error_caching_min_ttl = 120
  }

  custom_error_response {
    error_code            = 404
    response_code         = 404
    response_page_path    = "/index.html"
    error_caching_min_ttl = 120
  }

  custom_error_response {
    error_code            = 500
    response_code         = 500
    response_page_path    = "/index.html"
    error_caching_min_ttl = 120
  }

  custom_error_response {
    error_code            = 502
    response_code         = 502
    response_page_path    = "/index.html"
    error_caching_min_ttl = 120
  }

  custom_error_response {
    error_code            = 503
    response_code         = 503
    response_page_path    = "/index.html"
    error_caching_min_ttl = 120
  }

  # logging_config

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.default.id
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2019"
    ssl_support_method             = "sni-only"
  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = var.description
  http_version    = "http2"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = local.resource_tags
}
