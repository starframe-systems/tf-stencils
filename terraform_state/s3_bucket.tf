resource "aws_s3_bucket" "state" {
  bucket = "${local.account_id}-${local.region_name}-tfstate"
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}
