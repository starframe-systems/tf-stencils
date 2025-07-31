locals {
  openid_url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

data "external" "thumbprint" {
  program = ["bin/thumbprint.sh", local.openid_url]
}

resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [data.external.thumbprint.result.thumbprint]
}
