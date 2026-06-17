locals {
  function_name = "${var.env_name}_${var.prefix}_${var.name}"
  # function_name = "${var.prefix}/${var.name}/${var.env_name}"
}
