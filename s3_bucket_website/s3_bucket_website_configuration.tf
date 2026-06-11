resource "aws_s3_bucket_website_configuration" "default" {
  lifecycle {
    precondition {
      condition = (var.redirect_all_requests_to != null && var.error_document == null && var.index_document_suffix == null && var.routing_rules == null) || (var.redirect_all_requests_to == null)
      error_message = "Conflict: `error_document`, `index_document_suffix`, and `routing_rules` may not be provided if `redirect_all_requests_to` is provided."
    }
  }
  
  bucket = var.bucket_name

  dynamic "index_document" {
    for_each = var.redirect_all_requests_to == null ? [1] : []

    content {
      suffix = var.index_document_suffix != null ? var.index_document_suffix : "index.html"
    }
  }

  dynamic "error_document" {
    for_each = var.redirect_all_requests_to == null ? [1] : []

    content {
      key = var.error_document != null ? var.error_document : "error.html"
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = var.redirect_all_requests_to != null ? [1] : []

    content {
      host_name = var.redirect_all_requests_to.host_name
      protocol  = var.redirect_all_requests_to.protocol
    }
  }

  routing_rules = var.routing_rules
}
