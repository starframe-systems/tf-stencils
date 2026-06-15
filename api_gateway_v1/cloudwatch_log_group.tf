resource "aws_cloudwatch_log_group" "main" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.main.id}/${var.api_gateway_stage_name}"
  retention_in_days = 30
  tags              = local.resource_tags
}
