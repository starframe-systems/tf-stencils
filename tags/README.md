# Tags

The tags module creates a nestable structure to manage tags that should be shared across groups of resources.

For example, a tag module can be created for a specific environment, and its output can be passed into a module definition for tags at the service level. The service-level tag module may add its own tags, which are passed into the stencil that manages individual resources.

## Example

In this example, the Lambda function gets tags from both in the Stencil definition and the Service definition. The Tags Stencil merges the inherited tags and the local tags to pass the combined map to the Terraformed resources.

_lambda/main.tf:_

```
variable "inherited_tags" {
  type        = map(string)
  description = "Inherited tags to be assigned to managed resources"
  default     = {}
}

module "tags" {
    source          = "git@github.com:starframe-systems/tf-stencils.git//tags?ref=0.9.1"
    inherited_tags  = var.inherited_tags
    additional_tags = {
        "starframe.stencil.name"           = "lambda"
        "starframe.stencil.version"        = "0.1.3"
        "starframe.stencil.repository_url" = "starframe-systems/tf-stencils.git"
    }
}

resource "aws_lambda_function" {
    function_name = "${local.prefix}_${local.name}"

    # ...

    tags = module.tags.combined_tags
}
```

_service.tf:_

```
variable "inherited_tags" {
  type = map(string)
  description = "Inherited tags"
  default = {}
}

module "tags" {
    source          = "git@github.com:starframe-systems/tf-stencils.git//tags?ref=0.9.1"
    inherited_tags  = var.inherited_tags
    additional_tags = {
        "service.name" = "DemoService"
        "service.version" = "2.1.2"
        "service.repository_url" = "starframe-systems/demo-service.git"
    }
}

module "lambda" {
    source = "git@github.com:starframe-systems/tf-stencils.git//lambda?ref=0.9.1"

    # ...

    context = var.context
    inherited_tags = module.tags.combined_tags
}
```

## Variables

**`enable_inheritance`**

- **Type:** bool
- **Description:** Expose inherited tags in output map when true
- **Default:** `true`

**`inherited_tags`**

- **Type:** map(string)
- **Description:** Map of inherited tags from parent context
- **Default:** `{}`

**`additional_tags`**

- **Type:** map(string)
- **Description:** Map of tags to add to the current context
- **Default:** `{}`

## Outputs

**`combined_tags`**

- **Description:** The tag map; either the merged tags if the `enable_inheritance` variable is true, otherwise only `additional_tags`
