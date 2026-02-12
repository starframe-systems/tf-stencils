# EventBridge Schedule resources are not able to be tagged. The schedule group
# allows us to associate tags with the schedule.

resource "aws_scheduler_schedule_group" "default" {
  name = local.scheduler_name
  tags = module.tags.combined_tags
}
