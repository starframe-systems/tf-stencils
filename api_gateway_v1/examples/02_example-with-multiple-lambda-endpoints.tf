module "ListUsers" {
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v0.1.4"

  env_name           = var.env_name
  prefix             = local.prefix
  name               = "ListUsersHandler"
  ecr_repository_url = "${var.aws_ecr_registry_base_url}/${lower(var.github_repo_name)}/${lower(local.handler)}"
  image_tag          = var.github_ref

  inherited_tags = module.inherited_tags

  newrelic_widget_index = 1
  newrelic_account_id   = data.newrelic_account.default.account_id
}

module "CreateUser" {
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v0.1.4"

  env_name           = var.env_name
  prefix             = local.prefix
  name               = "CreateUserHandler"
  ecr_repository_url = "${var.aws_ecr_registry_base_url}/${lower(var.github_repo_name)}/${lower(local.handler)}"
  image_tag          = var.github_ref

  inherited_tags = module.inherited_tags

  newrelic_widget_index = 1
  newrelic_account_id   = data.newrelic_account.default.account_id
}

module "GetUser" {
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v0.1.4"

  env_name           = var.env_name
  prefix             = local.prefix
  name               = "GetUserHandler"
  ecr_repository_url = "${var.aws_ecr_registry_base_url}/${lower(var.github_repo_name)}/${lower(local.handler)}"
  image_tag          = var.github_ref

  inherited_tags = module.inherited_tags

  newrelic_widget_index = 1
  newrelic_account_id   = data.newrelic_account.default.account_id
}

module "Gateway" {
  source     = "git@github.com:starframe-systems/tf-stencils.git//api_gateway_v1?ref=v0.1.4"
  depends_on = [module.Handler]

  name        = "HelloHandler"
  prefix      = local.prefix
  description = "API Gateway for HelloHandler"

  api_gateway_stage_name = "live"
  openapi_paths = {
    "/users" = {
      get = {
        responses = {
          "200" = {
            description = "Success"
          }
          "401" = {
            description = "Unauthorized"
          }
        }
        x-amazon-apigateway-auth = {
          type = "NONE"
        }
        x-amazon-apigateway-integration = {
          type       = "aws_proxy"
          httpMethod = "POST"
          responses = {
            default = {
              statusCode = "200"
            }
          }
          passthroughBehavior = "when_no_match"
          timeoutInMillis     = 29000
          connectionType      = "INTERNET"
          uri                 = module.ListUsers.function_invoke_arn
        }
      }
      post = {
        responses = {
          "201" = {
            description = "Created"
          }
          "401" = {
            description = "Unauthorized"
          }
        }
        x-amazon-apigateway-auth = {
          type = "NONE"
        }
        x-amazon-apigateway-integration = {
          type       = "aws_proxy"
          httpMethod = "POST"
          responses = {
            default = {
              statusCode = "200"
            }
          }
          passthroughBehavior = "when_no_match"
          timeoutInMillis     = 29000
          connectionType      = "INTERNET"
          uri                 = module.CreateUser.function_invoke_arn
        }
      }
    }
    "/users/{userId}" = {
      get = {
        responses = {
          "200" = {
            description = "Success"
          }
          "401" = {
            description = "Unauthorized"
          }
          "404" = {
            description = "Not found"
          }
        }
        x-amazon-apigateway-auth = {
          type = "NONE"
        }
        x-amazon-apigateway-integration = {
          type       = "aws_proxy"
          httpMethod = "POST"
          responses = {
            default = {
              statusCode = "200"
            }
          }
          passthroughBehavior = "when_no_match"
          timeoutInMillis     = 29000
          connectionType      = "INTERNET"
          uri                 = module.GetUser.function_invoke_arn
        }
      }
    }
  }

  inherited_tags      = module.inherited_tags
  newrelic_account_id = data.newrelic_account.default.account_id
}

resource "aws_lambda_permission" "invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.ListUsers.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.Gateway.execution_arn}/*"
}

resource "aws_lambda_permission" "invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.CreateUser.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.Gateway.execution_arn}/*"
}

resource "aws_lambda_permission" "invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.GetUser.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.Gateway.execution_arn}/*"
}
