module "tags" {
  source         = "../tags"
  inherited_tags = var.inherited_tags
  additional_tags = {
    "starframe.stencil.name"           = "terraform_state"
    "starframe.stencil.version"        = "0.1.2"
    "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
  }
}
