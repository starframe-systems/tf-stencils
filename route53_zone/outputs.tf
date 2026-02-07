output "iam_policy_arn" {
  value = {
    "read-only" = aws_iam_policy.read-only.arn
    "modify"    = aws_iam_policy.modify.arn
  }
}
