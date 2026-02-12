variable "aws_region" {
  type        = string
  description = "The AWS region identifier the EventBridge Scheduler is to be deployed in"
  default     = "us-west-2"

  validation {
    condition = contains([
      "us-east-1",
      "us-east-2",
      "us-west-1",
      "us-west-2",
      "ca-central-1",
      "ca-west-1",
      "ca-central-1",
      "mx-central-1",
      "eu-central-1",
      "eu-central-2",
      "eu-west-1",
      "eu-west-2",
      "eu-west-3",
      "eu-south-1",
      "eu-south-2",
      "eu-north-1",
      "il-central-1",
      "me-south-1",
      "me-central-1",
      "sa-east-1",
      "af-south-1",
      "ap-south-1",
      "ap-south-2",
      "ap-southeast-1",
      "ap-southeast-2",
      "ap-southeast-3",
      "ap-southeast-4",
      "ap-southeast-5",
      "ap-southeast-7",
      "ap-northeast-1",
      "ap-northeast-2",
      "ap-northeast-3",
    ], var.aws_region)
    error_message = "The specified region identifier was not recognized."
  }
}

variable "env_name" {
  type        = string
  description = "The name of the environment resources are deployed in"
}

variable "prefix" {
  type        = string
  description = "A prefix prepended to all resource names in this module"
}

variable "name" {
  type        = string
  description = "A unique name for the EventBridge Schedule"
}

variable "description" {
  type        = string
  description = "A description of the EventBridge Schedule"
  default     = null
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}

variable "schedules" {
  type = list(object({
    schedule_expression = string
    target_arn          = string
    target_event_input  = string
  }))
  description = <<EOF
        List of specifications for individual schedules in the Schedule Group
        Each specification is a dictionary consisting of:
        - A `schedule_expression` that defines when the scheduled event runs
        - The `target_arn` of the Lambda that is invoked by the scheduled event
        - A `target_event_input` payload string that is sent to the target event when run
    EOF
  default     = []

  validation {
    condition = length([for sched in var.schedules : true
    if can(regex("^(?:rate)|(?:cron)|(?:at)", sched.schedule_expression))]) == length(var.schedules)
    #can(regex("^(?:rate)|(?:cron)|(?:at)", sched.schedule_expression))
    error_message = "Supported schedule types are 'rate', 'cron', and 'at'; See https://docs.aws.amazon.com/scheduler/latest/UserGuide/schedule-types.html"
  }

  validation {
    condition = length([for sched in var.schedules : true
    if can(regex("^(?:rate)|(?:cron)|(?:at)\\(.*\\)$", sched.schedule_expression))]) == length(var.schedules)
    error_message = "A parenthesized schedule expression is expected after the schedule type; See https://docs.aws.amazon.com/scheduler/latest/UserGuide/schedule-types.html"
  }

}
