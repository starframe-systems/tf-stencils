
resource "aws_route53_zone" "this" {
  count   = var.created_by_route53_registrar ? 0 : 1
  name    = local.zone_name
  comment = <<-EOT
    ${local.zone_name} (managed by Terraform in the [REPOSITORY] repo)
  EOT

  tags = local.resource_tags
}

data "aws_route53_zone" "this" {
  count = var.created_by_route53_registrar ? 1 : 0
  name  = local.zone_name

  private_zone = false

  tags = local.resource_tags
}
