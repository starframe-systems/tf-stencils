
resource "aws_lambda_event_source_mapping" "this" {
  count            = length(var.event_source_arns)
  event_source_arn = var.event_source_arns[count.index]
  function_name    = aws_lambda_function.default.arn
}
