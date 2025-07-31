
output "account_id" {
  value = local.account_id
}

output "tf_state_bucket" {
  value = aws_s3_bucket.state
}

output "tf_state_lock_table" {
  value = aws_dynamodb_table.state-lock
}
