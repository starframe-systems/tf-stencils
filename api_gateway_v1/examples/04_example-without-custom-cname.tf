module "gateway" {
  source                      = "git@github.com:starframe-systems/tf-stencils.git//api_gateway_v1?ref=v0.1.4"
  name                        = "handler"
  prefix                      = local.prefix
  handler_function_name       = module.handler.function_name
  handler_function_invoke_arn = module.handler.function_invoke_arn
  newrelic_account_id         = data.newrelic_account.default.account_id
  inherited_tags = {
    enabled = true
    tags    = local.tags
  }
  depends_on = [module.handler]
}
