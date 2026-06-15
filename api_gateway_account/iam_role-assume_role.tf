
resource "aws_iam_role" "cloudwatch" {
  name               = "AmazonAPIGatewayPushToCloudWatchLogs"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# The API Gateway Account resource requires `sts:AssumeRole` on the API Gateway service...
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# ...and the AWS-managed "AmazonAPIGatewayPushToCloudWatchLogs" permissions
resource "aws_iam_role_policy_attachment" "push_to_cloudwatch_logs" {
  role       = aws_iam_role.cloudwatch.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}
