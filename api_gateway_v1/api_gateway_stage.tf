resource "aws_api_gateway_stage" "main" {
  rest_api_id           = aws_api_gateway_rest_api.main.id
  deployment_id         = aws_api_gateway_deployment.main.id
  stage_name            = var.api_gateway_stage_name
  cache_cluster_enabled = "false"
  description           = "${var.prefix} API Gateway stage"
  xray_tracing_enabled  = "true"
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.main.arn
    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }
  depends_on = [aws_cloudwatch_log_group.main]
  tags       = module.tags.combined_tags
}
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.main.id,
      aws_api_gateway_rest_api.main.body
    ]))
  }
  depends_on = [aws_api_gateway_rest_api.main]
  lifecycle {
    create_before_destroy = true
  }
}
