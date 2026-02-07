variable "aws_region" {
  type        = string
  description = "The AWS region identifier the function is to be deployed in"
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
  description = "A unique name for the Lambda function"
}

variable "description" {
  type        = string
  description = "A description of the Lambda function"
  default     = null
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}

variable "architectures" {
  type        = list(string)
  description = "List of machine architectures the Lambda function can run on; allowed values are 'arm64' (default) and 'x86_64'"
  default     = ["arm64"]

  validation {
    condition = length([
      for arch in var.architectures : true
      if contains(["arm64", "x86_64"], arch)
    ]) == length(var.architectures)
    error_message = "The architectures variable should be [\"arm64\"], [\"x86_64\"], or [\"arm64\", \"x86_64\"]"
  }
}

variable "event_source_arns" {
  type        = list(string)
  description = "list of Lambda event source ARNs to attach to the function"
  default     = []
}

variable "environment_variables" {
  type        = map(string)
  description = "Map of environment variable names and values to supply to the Lambda function"
  default     = {}
}

variable "ephemeral_storage_size" {
  type        = number
  description = "The Lambda function's disk size in MB"
  default     = 512
}

variable "memory_size" {
  type        = number
  description = "The Lambda function's volatile memory size in MB"
  default     = 128
}

variable "timeout" {
  type        = number
  description = "The Lambda function's maximum execution duration in seconds"
  default     = 3
}

variable "image_repository_url" {
  type        = string
  description = "The ECR Repository URL for the Lambda function's image"
}

variable "image_tag" {
  type        = string
  description = "The docker image tag to request from the ECR Repository"
  default     = "latest"
}

variable "enable_xray" {
  type        = bool
  description = "Whether AWS X-Ray tracing is enabled for the Lambda function"
  default     = false
}

variable "xray_tracing_mode" {
  type        = string
  description = "X-Ray tracing mode ('Active' or 'PassThrough'). Only used if X-Ray is enabled."
  default     = "PassThrough"

  validation {
    condition     = contains(["Active", "PassThrough"], var.xray_tracing_mode)
    error_message = "Unrecognized `xray_tracing_mode` value. Valid X-Ray tracing modes are 'Active' and 'PassThrough'."
  }
}

variable "function_url" {
  type = object({
    enable             = bool
    authorization_type = optional(string, "NONE")
    qualifier          = optional(string)
  })
  description = "value"
  default = {
    enable             = false
    authorization_type = null
    qualifier          = null
  }

  validation {
    condition     = contains(["NONE", "AWS_IAM"], var.function_url.authorization_type)
    error_message = "The `authorization_type` value should be either 'NONE' or 'AWS_IAM'"
  }
}

variable "function_url_cors" {
  type = object({
    allow_credentials = optional(bool, false)
    allow_headers     = optional(list(string), [])
    allow_methods     = optional(list(string), [])
    allow_origins     = optional(list(string), [])
    expose_headers    = optional(list(string), [])
    max_age           = optional(number, 0)
  })
  description = "The cross-origin resource sharing (CORS) settings for the function URL; all values are optional; see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url#cors"
  default     = {}

  validation {
    condition = var.function_url_cors != null && length([for method in var.function_url_cors.allow_methods : true
    if contains(["OPTIONS", "HEAD", "GET", "PUT", "POST", "PATCH", "DELETE", "*"], method)]) == length(var.function_url_cors.allow_methods)
    error_message = "Unexpected method name"
  }

  validation {
    condition     = var.function_url_cors.max_age >= 0
    error_message = "The `max_age` parameter must be between 0 and 86400 (inclusive)"
  }

  validation {
    condition     = var.function_url_cors.max_age <= 86400
    error_message = "The `max_age` parameter must be between 0 and 86400 (inclusive)"
  }
}

variable "execution_role_policy_arns" {
  type        = list(string)
  description = "A list of AWS Policy ARNs to attach to the Lambda function's execution role"
  default     = []
}
