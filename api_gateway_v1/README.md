# api_gateway_v1

Creates an API Gateway (v1) REST API.

The module provides three ways to specify the resource paths and methods exposed by the API. An AWS Lambda function name can be provided, in which case all requests are proxied to the specified function; a mapping of path strings to [API Gateway integration objects][x-amazon-apigateway-integration] that is interpolated into an OpenAPI definition template; or a raw [OpenAPI definition file][openapi-in-api-gateway].

A single stage is created for API deployment. Deployments are triggered if the OpenAPI definition (in the `body` property of the API Gateway resource) changes.

An optional custom CNAME can be provided for the stage endpoint, with an ACM certificate for HTTPS.

> [!NOTE]  
> The account this module is deployed in must have an **API Gateway CloudWatch Logging** role configured, as well as the AWS-managed `AmazonAPIGatewayPushToCloudWatchLogs` policy.
>
> ```
> {
>   "Version": "2012-10-17",
>   "Statement": [
>     {
>       "Sid": "",
>       "Effect": "Allow",
>       "Principal": {
>         "Service": "apigateway.amazonaws.com"
>       },
>       "Action": "sts:AssumeRole"
>     }
>   ]
> }
> ```

[x-amazon-apigateway-integration]: https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-swagger-extensions-integration.html
[openapi-in-api-gateway]: https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api.html

## Examples

For complete examples, see the Terraform files in the [`examples/` directory][examples].

[examples]: https://github.com/starframe-systems/tf-stencils/tree/main/api_gateway_v1/examples

### Basic API with single Lambda Integration

The single Lambda integration example shows the simplest configuration for an API Gateway and Lambda function. Simply specify the `handler_function_name` as an attribute of the API Gateway module definition.

<details><summary>Terraform definitions for single Lambda integration</summary><p>

```
module "handler" {
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v1.0.2"

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
  source = "git@github.com:starframe-systems/tf-stencils.git//api_gateway_v1?ref=v1.0.2"

  name        = "HelloGateway"
  prefix      = local.prefix
  description = "API Gateway for HelloHandler"

  api_gateway_stage_name = "live"
  handler_function_name  = module.handler.function_name

  inherited_tags      = module.inherited_tags
  newrelic_account_id = data.newrelic_account.default.account_id
}
```

</details>

### API with Multiple Lambda Endpoints

The multiple Lambda endpoint example shows a more complex configuration for an API Gateway with multiple Lambda functions. Instead of specifying a `handler_function_name` attribute, the `openapi_paths` attribute is used. The `openapi_paths` value should be a map of path strings to OpenAPI resource definitions in HACL format.

> [!Note]
> When using the `openapi_paths` variable, `aws_lambda_permission` resources must be created manually for each function associated with an API Gateway integration.
>
> ```
> resource "aws_lambda_permission" "invoke" {
>   statement_id  = "AllowExecutionFromAPIGateway"
>   action        = "lambda:InvokeFunction"
>   function_name = module.Lambda.function_name
>   principal     = "apigateway.amazonaws.com"
>   source_arn    = "${module.Gateway.execution_arn}/*"
> }
> ```

<details><summary>Terraform definitions for multiple Lambda endpoints</summary><p>

```
module "ListUsers" {
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v1.0.2"

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
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v1.0.2"

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
  source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v1.0.2"

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
  source     = "git@github.com:starframe-systems/tf-stencils.git//api_gateway_v1?ref=v1.0.2"
  depends_on = [module.Handler]

  name        = "HelloHandler"
  prefix      = local.prefix
  description = "API Gateway for HelloHandler"

  api_gateway_stage_name = "live"
  openapi_paths = {
    "/users"   = {
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
```

</details>

### API Gateway with Custom OpenAPI Definition

Rather than specifying a map of OpenAPI path definitions, the API Gateway module can also be configured with a custom OpenAPI definition document. The `openapi_specification` attribute expects a YAML-encoded OpenAPI document. It is up to the developer to separately configure any resources the document references.

<details><summary>Terraform definitions for custom OpenAPI definition</summary><p>
</details>

## Variables

**`name`**

- **Type:** string
- **Description:** name of this invocation of this module; ex: 'apigw' (generic use), or 'handler' (handler-specific-use)

**`description`**

- **Type:** string
- **Description:** arbitrary description of this api gateway and its purpose
- **Default:** default description change me

**`prefix`**

- **Type:** string
- **Description:** string to prepend to all resource names; Ex: 'org-dev-usersvc-'; this would result in resource names like 'org-dev-usersvc-handler-apigw'

**`openapi_paths`**

- **Type:** map(any)
- **Description:** List of OpenAPI integration objects that define routes for the REST API. Mutually exclusive with `openapi_specification` and `handler_function_name`.
- **Default:** `{}`

**`openapi_specification`**

- **Type:** string
- **Description:** OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. Mutually exclusive with `openapi_paths` and `handler_function_name`.
- **Default:** `null`

**`handler_function_name`**

- **Type:** string
- **Description:** The name of the handler Lambda function. Required for the default OpenAPI specification to work and mutually exclusive with `openapi_paths` and `openapi_specification`.
- **Default:** `null`

**`api_gateway_stage_name`**

- **Type:** string
- **Description:** name of the api gateway stage; appears in the invoke url: `https://.../<stage_name>`
- **Default:** `default_stage_name_change_me`

**`inherited_tags`**

- **Type:** any
- **Description:** Inheritance chain of common tags to apply to AWS resources

**`enable_custom_cname_creation`**

- **Type:** bool
- **Description:** enable creating a new custom CNAME, if this is enabled, then a new API Gateway resource will be created'
- **Default:** false

**`enable_custom_cname`**

- **Type:** bool
- **Description:** enable custom CNAME record pointing to gateway stage endpoint; I.e.: 'https://api.env.example.org/live' insead of 'https://2zxiqdoqbc.execute-api.us-west-2.amazonaws.com/live'
- **Default:** false

**`custom_cname_hostname`**

- **Type:** string
- **Description:** hostname portion of endpoint CNAME record, without the domain name; I.e.: the 'api' in 'api.env.example.org'

**`custom_cname_domain`**

- **Type:** string
- **Description:** domain portion of the endpoint CNAME, without the hostname; I.e.: the 'env.example.org' in 'api.env.example.org'; domain must be a Route53 hosted zone in the same AWS account for automatic cert validation and CNAME record creation

**`custom_cname_base_path_map`**

- **Description:** path portion of the endpoint CNAME, without the hostname; I.e.: the 'path' in 'api.env.example.org/path'
- **Default:** null

**`custom_cname_route53_zone_id`**

- **Type:** string
- **Description:** Route53 hosted zone ID for custom_cname_domain
- **Default:** null

## Outputs

**`stage`**

- **Description:** The API Gateway stage

**`raw_invoke_url`**

- **Description:** The API Gateway stage's invoke URL

**`custom_cname`**

- **Description:** The API Gateway's custom CNAME, if specified, otherwise `null`

**`invoke_url`**

- **Description:** If a custom CNAME is specified, a URL using the CNAME for the domain, otherwise the API Gateway stage's invoke URL

**`invoke_gateway_id`**

- **Description:** The API Gateway ID

**`execution_arn`**

- **Description:** The ARN to be used in an `aws_lambda_permission` resource's `source_arn` argument when allowing API Gateway to invoke a Lambda function

**`cloudwatch_log_group_arn`**

- **Description:** The ARN of the API Gateway's CloudWatch Log Group

**`cloudwatch_log_group_name`**

- **Description:** The name of the API Gateway's CloudWatch Log Group
