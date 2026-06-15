
resource "aws_api_gateway_account" "main" {
  depends_on = [ aws_iam_role.cloudwatch ]
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}
