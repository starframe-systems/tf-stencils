data "aws_iam_policy_document" "Put" {
  statement {
    actions = [
      "dynamodb:PutItem",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }
}
resource "aws_iam_policy" "Put" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBPut"
  policy = data.aws_iam_policy_document.Put.json
  tags   = local.resource_tags
}
