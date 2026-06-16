data "aws_iam_policy_document" "Scan" {
  statement {
    actions = [
      "dynamodb:Scan",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }
}
resource "aws_iam_policy" "Scan" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBScan"
  policy = data.aws_iam_policy_document.Scan.json
  tags   = local.resource_tags
}
