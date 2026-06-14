module "tags" {
  source         = "../tags"
  inherited_tags = var.inherited_tags
  additional_tags = {
    "starframe.stencil.name"           = "github_oidc_policy"
    "starframe.stencil.version"        = "0.1.7"
    "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
  }
}
