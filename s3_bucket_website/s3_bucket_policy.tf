
resource "aws_s3_bucket_policy" "public-read" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.public-read.json
}

data "aws_iam_policy_document" "public-read" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}
