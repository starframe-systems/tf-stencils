data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  region         = data.aws_region.current.name
  aws_account_id = data.aws_caller_identity.current.account_id
  prefix         = "${var.prefix}-${var.name}"
}
