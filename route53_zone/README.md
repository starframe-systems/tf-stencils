# route53_zone

Creates a Route53 Hosted Zone

## Example

```
module "route53_zone" {
    source = "git@github.com:starframe-systems/tf-stencils.git//route53_zone?ref=v0.1.4"

    domain_name  = "example.org"
    account_name = "ExampleDotOrg"
    role_name    = var.aws_iam_role.name
}
```

## Variables

**`domain_name`**

- **Type**: `string`
- **Description**: Domain name for the Route53 Hosted Zone

**`created_by_route53_registrar`**

- **Type**: `bool`
- **Description**: True if the Route53 Zone was automatically created by the AWS Domain Registrar
- **Default**: `false`

**`inherited_tags`**

- **Type**: `map(string)`
- **Description**: Map of tags inherited from parent context

**`role_name`**

- **Type**: `string`
- **Description**: Name of the IAM Role that provides cross-account Route53 access

**`account_name`**

- **Type**: `string`
- **Description**: Account alias of the AWS account within the Organization heirarchy

## Outputs

**`hosted_zone_id`**

- **Description:** The ID of the Route53 Hosted Zone

**`hosted_zone_arn`**

- **Description:** The ARN of the Route53 Hosted Zone

**`name_servers`**

- **Description:** A list of name servers in associated (or default) delegation set

**`primary_name_server`**

- **Description:** The Route 53 name server that created the SOA record

**`iam_policy_arn`**

- **Description:** A dictionary of IAM policies that can be attached to execution roles on other resources

  Available policy keys are `read-only` and `modify`.
