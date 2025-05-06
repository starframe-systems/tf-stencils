resource "aws_lambda_function" "default" {
  function_name = local.function_name
  description   = var.description != null ? var.description : "[${var.env_name}]: ${var.name}"
  role          = aws_iam_role.execution.arn

  package_type = "Image"
  image_uri    = "${var.image_repository_url}:${var.image_tag}"

  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = "-1"
  architectures                  = var.architectures

  ephemeral_storage {
    size = var.ephemeral_storage_size
  }

  environment {
    variables = var.environment_variables
  }

  dynamic "tracing_config" {
    for_each = var.enable_xray ? [1] : []
    content {
      mode = var.xray_tracing_mode
    }
  }

  logging_config {
    log_format = "JSON"
  }

  tags = module.tags.combined_tags
}
