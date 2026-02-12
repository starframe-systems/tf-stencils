resource "aws_scheduler_schedule" "default" {
  count      = length(var.schedules)
  name       = "${local.scheduler_name}_schedule_${count.index}"
  group_name = aws_scheduler_schedule_group.default.name

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = var.schedules[count.index].schedule_expression

  target {
    arn      = var.schedules[count.index].target_arn
    role_arn = aws_iam_role.event_bridge_assume_role.arn
    input    = var.schedules[count.index].target_event_input
  }
}
