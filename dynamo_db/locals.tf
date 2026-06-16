data "aws_region" "current" {}

locals {
  module_name   = "dynamo_db"
  resource_tags = module.tags.combined_tags
  region        = data.aws_region.current.name
}
