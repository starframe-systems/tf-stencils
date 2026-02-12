# Creates a policy that the EventBridge service can assume giving the
# service permission to invoke the target Lambda functions

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "event_bridge_assume_role" {
  name               = "${local.scheduler_name}_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = module.tags.combined_tags
}

data "aws_iam_policy_document" "event_bridge_execution_policy" {
  count = length(local.distinct_target_arns)
  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = [local.distinct_target_arns[count.index]]
  }
}

resource "aws_iam_policy" "event_bridge_execution_policy" {
  count  = length(local.distinct_target_arns)
  name   = "${local.scheduler_name}_Scheduler_Execution"
  policy = data.aws_iam_policy_document.event_bridge_execution_policy[count.index].json
  tags   = module.tags.combined_tags
}

resource "aws_iam_role_policy_attachment" "event_bridge_execution" {
  count      = length(local.distinct_target_arns)
  role       = aws_iam_role.event_bridge_assume_role.name
  policy_arn = aws_iam_policy.event_bridge_execution_policy[count.index].arn
}
