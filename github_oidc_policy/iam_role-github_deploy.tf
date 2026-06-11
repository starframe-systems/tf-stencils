
resource "aws_iam_role" "github-deploy" {
  name_prefix          = "${replace(var.name, " ", "")}"
  max_session_duration = 3600
  assume_role_policy   = data.aws_iam_policy_document.assume-role-policy.json
}
