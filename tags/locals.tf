locals {
  inherited_tags = var.enable_inheritance ? var.inherited_tags : {}
  combined_tags  = merge(local.inherited_tags, var.additional_tags)
}
