data "aws_iam_policy_document" "ScanGSI" {
  count = length(var.global_secondary_indexes) > 0 ? 1 : 0

  dynamic "statement" {
    for_each = length(var.global_secondary_indexes) > 0 ? [1] : []

    content {
      actions = [
        "dynamodb:Scan",
      ]
      effect = "Allow"
      resources = [
        for gsi in var.global_secondary_indexes :
        "${aws_dynamodb_table.this.arn}/index/${gsi.name}"
      ]
    }
  }
}

resource "aws_iam_policy" "ScanGSI" {
  count = length(var.global_secondary_indexes) > 0 ? 1 : 0

  name   = "${var.prefix}_${var.table_name}_DynamoDBScanGSI"
  policy = data.aws_iam_policy_document.ScanGSI[0].json
  tags   = local.resource_tags
}
