data "aws_iam_policy_document" "Delete" {
  statement {
    actions = [
      "dynamodb:DeleteItem",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }
}
resource "aws_iam_policy" "Delete" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBDelete"
  policy = data.aws_iam_policy_document.Delete.json
  tags   = local.resource_tags
}
