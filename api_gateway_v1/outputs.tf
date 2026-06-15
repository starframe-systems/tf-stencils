output "stage" {
  value = aws_api_gateway_stage.main
}
output "raw_invoke_url" {
  value = aws_api_gateway_stage.main.invoke_url
}
output "custom_cname" {
  value = var.enable_custom_cname ? local.custom_cname : null
}
output "invoke_url" {
  value = var.enable_custom_cname ? "https://${local.custom_cname}" : aws_api_gateway_stage.main.invoke_url
}
output "invoke_gateway_id" {
  value = aws_api_gateway_rest_api.main.id
}
output "execution_arn" {
  value = aws_api_gateway_rest_api.main.execution_arn
}
output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}
output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.main.name
}
