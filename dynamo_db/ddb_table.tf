resource "aws_dynamodb_table" "this" {
  name         = "${var.prefix}_${var.table_name}"
  billing_mode = var.capacity == null ? "PAY_PER_REQUEST" : "ON_DEMAND"

  read_capacity  = var.capacity != null ? var.capacity.read_capacity : null
  write_capacity = var.capacity != null ? var.capacity.write_capacity : null

  hash_key  = var.hash_key
  range_key = var.range_key

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  # Add TTL block only if enable_ttl is true
  dynamic "ttl" {
    for_each = var.enable_ttl ? [1] : []
    content {
      attribute_name = var.ttl_attribute_name
      enabled        = true
    }
  }

  # Define attributes dynamically for GSIs
  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }
  # Add global secondary indexes dynamically
  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name = global_secondary_index.value.name
      key_schema {
        attribute_name = global_secondary_index.value.hash_key
        key_type       = "HASH"
      }
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = global_secondary_index.value.non_key_attributes
      read_capacity      = global_secondary_index.value.read_capacity
      write_capacity     = global_secondary_index.value.write_capacity
    }
  }
  tags = local.resource_tags
}


