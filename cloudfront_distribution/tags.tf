module "tags" {
  source         = "../tags"
  inherited_tags = var.inherited_tags
  additional_tags = {
    "starframe.stencil.name"           = "cloudfront_distribution"
    "starframe.stencil.version"        = "0.1.7"
    "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
  }
}
