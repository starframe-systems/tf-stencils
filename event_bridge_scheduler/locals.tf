locals {
  scheduler_name       = "${var.env_name}_${var.prefix}_${var.name}"
  distinct_target_arns = distinct([for s in var.schedules : s.target_arn])
}
