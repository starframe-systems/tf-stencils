module "tags" {
  source         = "../tags"
  inherited_tags = var.inherited_tags
  additional_tags = {
    "starframe.stencil.name"           = "api_gateway_v1"
    "starframe.stencil.version"        = "0.1.4"
    "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
  }
}
