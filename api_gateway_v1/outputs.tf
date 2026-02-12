output "stage" {
  value = aws_api_gateway_stage.this
}
output "raw_invoke_url" {
  value = aws_api_gateway_stage.this.invoke_url
}
output "custom_cname" {
  value = var.enable_custom_cname ? local.custom_cname : null
}
output "invoke_url" {
  value = var.enable_custom_cname ? "https://${local.custom_cname}" : aws_api_gateway_stage.this.invoke_url
}
output "invoke_gateway_id" {
  value = aws_api_gateway_rest_api.this.id
}
output "execution_arn" {
  value = aws_api_gateway_rest_api.this.execution_arn
}
output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.this.arn
}
output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.this.name
}
