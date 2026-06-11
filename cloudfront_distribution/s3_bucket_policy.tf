# Attaches a bucket policy to the S3 bucket to allow CloudFront to access it.
# Only created when using S3 as an origin for CloudFront without static website hosting enabled.

data "aws_s3_bucket" "default" {
  count = var.bucket_name != null ? 1 : 0

  bucket = var.bucket_name
}

resource "aws_s3_bucket_policy" "default" {
  count = var.bucket_name != null ? 1 : 0

  bucket = data.aws_s3_bucket.default[0].id
  policy = data.aws_iam_policy_document.cloudfront-get-object[0].json
}

data "aws_iam_policy_document" "cloudfront-get-object" {
  count = var.bucket_name != null ? 1 : 0

  statement {
    effect = "Allow"
    sid = "CloudFrontGetObject"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${data.aws_s3_bucket.default[0].arn}/*"
    ]

    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [
        "arn:aws:cloudfront::${local.account_id}:distribution/${aws_cloudfront_distribution.default.id}"
      ]
    }
  }
}
