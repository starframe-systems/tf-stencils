locals {
  body_default = (
    var.handler_function_name != null &&
    length(var.openapi_paths) == 0 &&
    var.openapi_specification == null
  )
  body_extensible = (
    var.handler_function_name == null &&
    length(var.openapi_paths) > 0 &&
    var.openapi_specification == null
  )
  body_custom = (
    var.handler_function_name == null &&
    length(var.openapi_paths) == 0 &&
    var.openapi_specification != null
  )
}

resource "aws_api_gateway_rest_api" "this" {
  name           = local.prefix
  description    = var.description
  api_key_source = "HEADER"
  body = (
    local.body_custom ? var.openapi_specification :
    local.body_extensible ? yamlencode(merge(local.openapi_stub, {
      paths = merge(var.openapi_paths, local.openapi_test_path)
    })) :
    templatefile("${path.module}/openapi_default.yaml", {
      aws_region               = local.region
      aws_account_id           = local.aws_account_id
      aws_lambda_function_name = var.handler_function_name
    })
  )

  disable_execute_api_endpoint = var.enable_custom_cname ? true : false
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  minimum_compression_size = "-1"
  tags                     = module.tags.combined_tags
}

resource "aws_lambda_permission" "invoke" {
  count         = local.body_default ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.handler_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*"
}
