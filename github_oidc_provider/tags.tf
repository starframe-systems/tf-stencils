module "tags" {
  source         = "../tags"
  inherited_tags = var.inherited_tags
  additional_tags = {
    "starframe.stencil.name"           = "github_oidc_provider"
    "starframe.stencil.version"        = "0.1.3"
    "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
  }
}
