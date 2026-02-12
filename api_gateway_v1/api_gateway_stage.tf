resource "aws_api_gateway_stage" "this" {
  rest_api_id           = aws_api_gateway_rest_api.this.id
  deployment_id         = aws_api_gateway_deployment.this.id
  stage_name            = var.api_gateway_stage_name
  cache_cluster_enabled = "false"
  description           = "${var.prefix} API Gateway stage"
  xray_tracing_enabled  = "true"
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.this.arn
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
  depends_on = [aws_cloudwatch_log_group.this]
  tags       = module.tags.combined_tags
}
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.this.id,
      aws_api_gateway_rest_api.this.body
    ]))
  }
  depends_on = [aws_api_gateway_rest_api.this]
  lifecycle {
    create_before_destroy = true
  }
}
