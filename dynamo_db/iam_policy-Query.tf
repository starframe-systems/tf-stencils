data "aws_iam_policy_document" "Query" {
  statement {
    actions = [
      "dynamodb:Query",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }
}
resource "aws_iam_policy" "Query" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBQuery"
  policy = data.aws_iam_policy_document.Query.json
  tags   = local.resource_tags
}
