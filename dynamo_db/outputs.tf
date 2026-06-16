output "table" {
  value = aws_dynamodb_table.this
}

output "iam_policy_arn" {
  value = {
    "Put"        = aws_iam_policy.Put.arn,
    "Get"        = aws_iam_policy.Get.arn,
    "Query"      = aws_iam_policy.Query.arn,
    "Scan"       = aws_iam_policy.Scan.arn,
    "Delete"     = aws_iam_policy.Delete.arn,
    "Update"     = aws_iam_policy.Update.arn,
    "QueryGSI"   = length(var.global_secondary_indexes) > 0 ? aws_iam_policy.QueryGSI[0].arn : null,
    "ScanGSI"    = length(var.global_secondary_indexes) > 0 ? aws_iam_policy.ScanGSI[0].arn : null,
    "BatchWrite" = aws_iam_policy.BatchWrite.arn,
    "FullAccess" = aws_iam_policy.FullAccess.arn,
  }
}
