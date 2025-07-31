resource "aws_dynamodb_table" "state-lock" {
  name         = "${local.account_id}-${local.region_name}-tfstate-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
