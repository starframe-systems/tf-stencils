# The CloudWatch log group should be created prior to the creation of the
# Lambda so that it can be managed by Terraform. Specifically, we need to be
# able to set the tags and the log retention policy.

resource "aws_cloudwatch_log_group" "default" {
  name = "/aws/lambda/${local.function_name}"
  tags = module.tags.combined_tags

  retention_in_days = 30
}
