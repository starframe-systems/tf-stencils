data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "origin" {
    count = var.bucket_name != null ? 1 : 0
    bucket = var.bucket_name
}

locals {
    account_id = data.aws_caller_identity.current.account_id
    resource_tags = {
        "starframe.stencil.name"           = "cloudfront_distribution"
        "starframe.stencil.version"        = "0.1.7"
        "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
        "created_by"                       = "${data.aws_caller_identity.current.arn}"
    }

    distribution_domain_name = coalesce(var.distribution_domain_name, var.bucket_name)
}
