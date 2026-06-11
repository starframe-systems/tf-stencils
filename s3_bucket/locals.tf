data "aws_region" "current" {}

locals {
  resource_tags = module.tags.combined_tags
  region        = data.aws_region.current.name
}
