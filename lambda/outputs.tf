output "function_name" {
  value       = aws_lambda_function.default.function_name
  description = "The name of the Lambda Function"
}

output "function_arn" {
  value       = aws_lambda_function.default.arn
  description = "The unqualified (no :QUALIFIER or :VERSION suffix) ARN identifying the Lambda Function"
}

output "function_qualified_arn" {
  value       = aws_lambda_function.default.qualified_arn
  description = "The qualified ARN (:QUALIFIER or :VERSION suffix) identifying the Lambda Function"
}

output "function_invoke_arn" {
  value       = aws_lambda_function.default.invoke_arn
  description = "The ARN to be used for invoking the Lambda Function from an API Gateway"
}

output "function_qualified_invoke_arn" {
  value       = aws_lambda_function.default.qualified_invoke_arn
  description = "The qualified (:QUALIFIER or :VERSION suffix) ARN to be used for invoking the Lambda Function from an API Gateway"
}

output "function_latest_published_version" {
  value       = aws_lambda_function.default.version
  description = "The latest published version of the Lambda Function"
}

output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.default.name
  description = "The name of the CloudWatch log group the function sends logs to"
}

output "cloudwatch_log_group_arn" {
  value       = aws_cloudwatch_log_group.default.arn
  description = "The ARN of the CloudWatch log group the function sends logs to"
}

output "execution_role_name" {
  value       = aws_iam_role.execution.name
  description = "The name of the Lambda Function's execution role"
}

output "execution_role_arn" {
  value       = aws_iam_role.execution.arn
  description = "The ARN of the Lambda Function's execution role"
}
