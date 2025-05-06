module "tags" {
  source         = "../tags"
  inherited_tags = var.inherited_tags
  additional_tags = {
    "starframe.stencil.name"           = "lambda"
    "starframe.stencil.version"        = "0.1.0"
    "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
  }
}
