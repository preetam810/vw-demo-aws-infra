locals {
  table_name = "${var.table_name}-${var.env_name}"
  shared_tags = var.shared_tags
}

resource "aws_dynamodb_table" "employee-dynamodb-table" {
  name           = local.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = local.shared_tags
}