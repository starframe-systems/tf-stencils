# The Lambda's exucution role is configured to allow the attachment of
# additional policies provided in the `execution_role_policy_arns` variable.
# Other templates in this library define and export policies that can be
# passed to the Lambda stencil for attachment to the execution role.

data "aws_iam_policy_document" "execution" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "execution" {
  name               = local.function_name
  assume_role_policy = data.aws_iam_policy_document.execution.json
  tags               = module.tags.combined_tags
}

resource "aws_iam_role_policy_attachment" "basic-execution-role" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "execution_role_policy_arns" {
  count      = length(var.execution_role_policy_arns)
  role       = aws_iam_role.execution.name
  policy_arn = var.execution_role_policy_arns[count.index]
}
