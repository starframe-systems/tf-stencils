module "handler" {
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v0.1.4"

  env_name           = var.env_name
  prefix             = local.prefix
  name               = local.handler
  ecr_repository_url = "${var.aws_ecr_registry_base_url}/${lower(var.github_repo_name)}/${lower(local.handler)}"
  image_tag          = var.github_ref

  environment_variables = {
    sqs_queue_url = module.Queue.queue_url
  }

  execution_role_policy_arns = [
    module.Queue.iam_policy_arn["send"],
  ]

  inherited_tags = module.inherited_tags

  newrelic_widget_index = 1
  newrelic_account_id   = data.newrelic_account.default.account_id
}

module "gateway" {
  source = "git@github.com:starframe-systems/tf-stencils.git//api_gateway_v1?ref=v0.1.4"

  name        = "HelloGateway"
  prefix      = local.prefix
  description = "API Gateway for HelloHandler"

  api_gateway_stage_name = "live"
  handler_function_name  = module.handler.function_name

  inherited_tags      = module.inherited_tags
  newrelic_account_id = data.newrelic_account.default.account_id
}
