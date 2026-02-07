output "iam_policy_arn" {
  value = {
    "read"   = aws_iam_policy.read.arn
    "write"  = aws_iam_policy.write.arn
    "delete" = aws_iam_policy.delete.arn
  }
}
