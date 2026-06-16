data "aws_iam_policy_document" "Update" {
  statement {
    actions = [
      "dynamodb:UpdateItem",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }
}
resource "aws_iam_policy" "Update" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBUpdate"
  policy = data.aws_iam_policy_document.Update.json
  tags   = local.resource_tags
}
