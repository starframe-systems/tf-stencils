locals {
  openapi_stub = {
    openapi = "3.0.3"

    info = {
      title       = ""
      description = <<-DESCR
        Creates a `/test` resource with a mock integration for health checks and
        provides a mechanism for developers to specify custom routing for any
        number of Lambda integrations.
      DESCR
      version     = "0.1.0"
    }
  }

  openapi_test_path = {
    "/test" = {
      get = {
        responses = {
          "200" = {
            description = "Success"
          }
        }
        x-amazon-apigateway-auth = {
          type = "NONE"
        }
        x-amazon-apigateway-integration = {
          type                = "mock"
          httpMethod          = "GET"
          connectionType      = "INTERNET"
          contentHandling     = "CONVERT_TO_TEXT"
          passthroughBehavior = "when_no_templates"
          timeoutInMillis     = 29000
          requestTemplates = {
            "application/json" = jsonencode({
              statusCode = 200
            })
          }
          requestParameters = {}
          responses = {
            "200" = {
              statusCode = "200"
              responseTemplates = {
                "application/json" = jsonencode({
                  http_method = "$context.httpMethod"
                  protocol    = "$context.protocol"
                  request_id  = "$context.requestId"
                })
              }
            }
          }
        }
      }
    }
  }
}
