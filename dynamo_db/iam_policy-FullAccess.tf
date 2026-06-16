data "aws_iam_policy_document" "FullAccess" {
  statement {
    actions = [
      "dynamodb:*",
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.this.arn]
  }

  dynamic "statement" {
    for_each = length(var.global_secondary_indexes) > 0 ? [1] : []
    content {
      actions = [
        "dynamodb:Query",
        "dynamodb:Scan"
      ]
      effect = "Allow"
      resources = [
        for gsi in var.global_secondary_indexes : 
        "${aws_dynamodb_table.this.arn}/index/${gsi.name}"
      ]
    }
  }
}

resource "aws_iam_policy" "FullAccess" {
  name   = "${var.prefix}_${var.table_name}_DynamoDBFullAccess"
  policy = data.aws_iam_policy_document.FullAccess.json
  tags   = local.resource_tags
}
