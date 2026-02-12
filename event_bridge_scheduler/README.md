# EventBridge Scheduler

The EventBridge Scheduler module creates an EventBridge Schedule Group for a collection of EventBridge Schedule resources. The schedule specification includes the timing expression, a target resource ARN and a target event payload.

## Example

```
module "CanaryWorker" {
    source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v0.1.0"

    name     = "CanaryWorker"
    prefix   = "CanaryService"
    env_name = "development"

    # ...
}

module "CanaryScheduler" {
  source = "git@github.com:starframe-systems/tf-stencils.git//event_bridge_scheduler?ref=v0.1.0"

  name     = "CanarySchedule"
  prefix   = "CanaryService"
  env_name = "development"

  schedules = [
    {
      schedule_expression = "rate(1 minutes)"
      target_arn          = module.CanaryWorker.function_arn
      target_event_input  = jsonencode({
        requests = [{
          url = "https://github.com/starframe-systems/tf-stencils"
        }]
      })
    }
  ]
}
```

## Variables

**`aws_region`**

- **Type:** string
- **Description:** The AWS region resources are to be deployed in
- **Default:** `us-west-2`

**`env_name`**

- **Type:** string
- **Description:** The name of the environment resources are deployed in

**`prefix`**

- **Type:** string
- **Description:** A prefix prepended to all resource names in this module

**`name`**

- **Type:** string
- **Description:** A unique name for the EventBridge Schedule

**`description`**

- **Type:** string
- **Description:** A description of the EventBridge Schedule
- **Default:** `null`

**`inherited_tags`**

- **Type:** map(string)
- **Description:** Map of inherited tags from parent context
- **Default:** `{}`

**`schedules`**

- **Type:**
  ```
  list(object({
    schedule_expression = string
    target_arn          = string
    target_event_input  = string
  }))
  ```
- **Description:** List of specifications for individual schedules in the Schedule Group. Each specification is a dictionary consisting of:
  - A `schedule_expression` that defines when the scheduled event runs
  - The `target_arn` of the Lambda that is invoked by the scheduled event
  - A `target_event_input` payload string that is sent to the target event when run
- **Default:** `[]`
