# dynamo_db

Creates a DynamoDB table with optionally specified attributes and global secondary indexes, and exposes IAM policies that cam be used in execution roles on other resources.

## Example

This example shows a minimal configuration of the DynamoDB module.

```
module "widget_svc_ddb" {
    source = "git@github.com:starframe-systems/tf-stencils.git//dynamo_db?ref=v0.1.9"

    prefix     = "Org-WidgetSvc"
    table_name = "Widgets"

    hash_key      = "id"
    hash_key_type = "S"

    range_key      = "ver"
    range_key_type = "S"
}
```

## Discussion

## Variables

**`prefix`**

- **Description:** Prefix to use in all resource names in this module
- **Type:** string

**`table_name`**

- **Description:** The name of the table to create
- **Type:** string

**`attributes`**

- **Description:** An optional list of additional DynamoDB attributes as mapped values with name and type fields
- **Type:** `list(object({
    name = string
    type = string
}))`

**`global_secondary_indexes`**

- **Description:** Specification of Global Secondary Indexes to create on the table
- **Type:**
  ```
  list(
    object({
      name               = string
      hash_key           = string
      projection_type    = string
      non_key_attributes = optional(list(string), [])
      read_capacity      = number
      write_capacity     = number
    })
  )
  ```

**`hash_key`**

- **Description:** The attribute name to use as the hash key
- **Type:** string

**`hash_key_type`**

- **Description:** The hash key type, which must be a DynamoDB scalar type identifier: S (string), N (number), or B (binary)
- **Default:** `S`
- **Type:** string

**`range_key`**

- **Description:** The attribute name to use as the range key
- **Type:** string

**`range_key_type`**

- **Description:** The range key type, which must be a DynamoDB scalar type identifier: S (string), N (number), or B (binary)
- **Default:** `S`
- **Type:** string

**`capacity`**

- **Description:** Read and write capacity values for provisioned billing mode. If this variable is not set, billing mode is `PAY_PER_REQUEST`.
- **Default:** `null`
- **Type:** `object({
read_capacity = number
write_capacity = number
})`

**`enable_point_in_time_recovery`**

- **Description:** Enable point-in-time recovery for the table
- **Default:** false
- **Type:** bool

**`enable_ttl`**

- **Description:** Enable TTL for items in the table
- **Default:** false
- **Type:** bool

**`ttl_attribute_name`**

- **Description:** The attribute name to use for TTL expiry
- **Type:** string

**`inherited_tags`**

- **Type:** any
- **Description:** Inheritance chain of common tags to apply to AWS resources

## Outputs

**`table`**

- **Description:** A reference to the table created by this module

**`iam_policy_arn`**

- **Description:** A dictionary of IAM policies that can be attached to execution roles on other resources

  Available policy keys are `Put`, `Get`, `Query`, `Scan`, `Delete`, `Update`, `QueryGSI`, `ScanGSI`, `BatchWrite`, and `FullAccess`.
