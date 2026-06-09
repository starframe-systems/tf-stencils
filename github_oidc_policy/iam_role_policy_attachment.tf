
resource "aws_iam_role_policy_attachment" "github-deploy-policy" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.github-deploy.name
  policy_arn = var.policy_arns[count.index]
}
