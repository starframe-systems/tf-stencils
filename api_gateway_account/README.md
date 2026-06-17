# API Gateway Account

The `aws_api_gateway_account` resource specifies the IAM role that Amazon API Gateway uses to write API logs to Amazon CloudWatch Logs. To avoid overwriting other roles, you should only have one `aws_api_gateway_account` resource per region per account.

When you delete a stack containing this resource, API Gateway can still assume the provided IAM role to write API logs to CloudWatch Logs. To deny API Gateway access to write API logs to CloudWatch logs, update the permissions policies or change the IAM role to deny access.

## Example

```
module "api_gateway_account" {
    source = "git@github.com:starframe-systems/tf-stencils.git//api_gateway_account?ref=v0.1.10"
}
```

## Variables

This module expects no variables.

## Outputs

This module provides no outputs.
