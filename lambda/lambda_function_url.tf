# Configures a Lambda Function URL and a resource-based policy if _ is set

resource "aws_lambda_function_url" "default" {
  count = var.function_url != null && var.function_url.enable ? 1 : 0

  function_name      = aws_lambda_function.default.function_name
  authorization_type = var.function_url.authorization_type
  qualifier          = var.function_url.qualifier

  dynamic "cors" {
    for_each = var.function_url_cors[*]

    content {
      allow_credentials = cors.allow_credentials
      allow_headers     = cors.allow_headers
      allow_methods     = cors.allow_methods
      allow_origins     = cors.allow_origins
      expose_headers    = cors.expose_headers
      max_age           = cors.max_age
    }
  }
}
