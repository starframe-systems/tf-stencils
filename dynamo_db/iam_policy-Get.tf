data "aws_iam_policy_document" "Get" {
  statement {
    actions = [
      "dynamodb:GetItem",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }
}
resource "aws_iam_policy" "Get" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBGet"
  policy = data.aws_iam_policy_document.Get.json
  tags   = local.resource_tags
}
