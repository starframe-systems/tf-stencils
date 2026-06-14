data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
    resource_tags = {
        "starframe.stencil.name"           = "cloudfront_distribution"
        "starframe.stencil.version"        = "0.1.7"
        "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
        "created_by"                       = "${data.aws_caller_identity.current.arn}"
    }
}
