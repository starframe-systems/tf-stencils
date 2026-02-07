data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  module_name = "route53_zone"
  # prefix      = "${var.prefix}-${var.name}"
  prefix        = coalesce(var.account_name, trimsuffix(var.name, "."))
  zone_name     = "${trimsuffix(var.name, ".")}."
  region        = data.aws_region.current.name
  account_id    = data.aws_caller_identity.current.account_id
  resource_tags = module.inherited_tags.combined_tags
}
