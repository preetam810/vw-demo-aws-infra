variable "env_name" {
  type    = string
}

variable "shared_tags" {
  type   = map(string)
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "aws_region" {
  description = "The name of the AWS region"
  type        = string
}

variable "object_key" {
  description = "The key of the object in the S3 bucket"
  type        = string
  default      = "*"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "employee"
}
