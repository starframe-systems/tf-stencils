
data "aws_iam_policy_document" "CreateInvalidation" {
  statement {
    actions = [
      "cloudfront:CreateInvalidation",
    ]
    effect    = "Allow"
    resources = [aws_cloudfront_distribution.default.arn]
  }
}

resource "aws_iam_policy" "CreateInvalidation" {
  name   = "Cloudfront_${aws_cloudfront_distribution.default.id}_CreateInvalidation"
  policy = data.aws_iam_policy_document.CreateInvalidation.json
  tags   = local.resource_tags
}
