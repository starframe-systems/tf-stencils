module "tags" {
  source         = "../tags"
  inherited_tags = var.inherited_tags
  additional_tags = {
    "starframe.stencil.name"           = "s3_bucket"
    "starframe.stencil.version"        = "0.1.10"
    "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
  }
}
