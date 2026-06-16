data "aws_iam_policy_document" "BatchWrite" {
  statement {
    actions = [
      "dynamodb:BatchWriteItem",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }
}
resource "aws_iam_policy" "BatchWrite" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBBatchWrite"
  policy = data.aws_iam_policy_document.BatchWrite.json
  tags   = local.resource_tags
}
