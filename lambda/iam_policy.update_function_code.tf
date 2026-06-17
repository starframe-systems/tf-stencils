
resource "aws_iam_policy" "UpdateFunctionCode" {
  name   = "${aws_lambda_function.default.function_name}-UpdateFunctionCode"
  policy = data.aws_iam_policy_document.UpdateFunctionCode.json
  tags   = module.tags.combined_tags
}

data "aws_iam_policy_document" "UpdateFunctionCode" {
  statement {
    sid = "UpdateFunctionCode"
    actions = [
      "lambda:UpdateFunctionCode",
    ]
    resources = [
      aws_lambda_function.default.arn
    ]
  }
}
