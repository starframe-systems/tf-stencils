# Lambda

The lambda module creates a lambda function and the requisite execution role policies for a flexible AWS Lambda Function.

## Example

```
module "demo-ddb" {
    source = "git@github.com:starframe-systems/tf-stencils.git//dynamo_db?ref=v0.1.0"

    # Additional configuration...
}

module "demo-function" {
    source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=v0.1.0"

    name = "demo-function"
    prefix = "DemoService"
    env_name = "development"

    environment_variables = {
        NODE_ENV = "dev"
    }

    image_repository_url = "public.ecr.aws/starframe/hello-world:latest"

    execution_role_policy_arns = [
        module.demo-ddb.iam_policy_arn['Put']
        module.demo-ddb.iam_policy_arn['Get']
        module.demo-ddb.iam_policy_arn['Scan']
        module.demo-ddb.iam_policy_arn['Query']
        module.demo-ddb.iam_policy_arn['Update']
        module.demo-ddb.iam_policy_arn['Delete']
    ]
}
```

## Variables

**`aws_region`**

**`env_name`**

**`prefix`**

**`name`**

**`description`**

**`inherited_tags`**

**`environment_variables`**

**`ephemeral_storage_size`**

**`memory_size`**

**`timeout`**

**`image_repository_url`**

**`image_tag`**

**`execution_role_policy_arns`**

## Outputs

**`function_name`**

- **Description:** The name of the Lambda Function

**`function_arn`**

- **Description:** The unqualified (no :QUALIFIER or :VERSION suffix) ARN identifying the Lambda Function

**`function_invoke_arn`**

- **Description:** The qualified ARN (:QUALIFIER or :VERSION suffix) identifying the Lambda Function

**`function_qualified_arn`**

- **Description:** The ARN to be used for invoking the Lambda Function from an API Gateway

**`function_qualified_invoke_arn`**

- **Description:** The qualified (:QUALIFIER or :VERSION suffix) ARN to be used for invoking the Lambda Function from an API Gateway

**`function_latest_published_version`**

- **Description:** The latest published version of the Lambda Function

**`cloudwatch_log_group_name`**

- **Description:** The name of the CloudWatch log group the function sends logs to

**`cloudwatch_log_group_arn`**

- **Description:** The ARN of the CloudWatch log group the function sends logs to

**`execution_role_name`**

- **Description:** The name of the Lambda Function's execution role

**`execution_role_arn`**

- **Description:** The ARN of the Lambda Function's execution role
