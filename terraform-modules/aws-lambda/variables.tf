variable "env_name" {
  type    = string
}

variable "shared_tags" {
  type   = map(string)
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "data_bucket_name" {
  description = "Name of the bucket which contains csv file"
  type        = string
}


variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_code_s3_bucket" {
  description = "S3 bucket where the Lambda code ZIP file is stored"
  type        = string
  default     = "vw-demo-730335502100-build-repository"
}

variable "build_repository_type" {
  description = "S3 key (path) to releases or snapshots repository"
  type        = string
}

variable "build_version_to_deploy" {
  description = "S3 key (path) to the Lambda ZIP file"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "lambda-s3-dynamodb.lambda_handler"  
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "python3.11"  
}

variable "memory_size" {
  description = "Lambda function memory size (MB)"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Lambda function timeout (seconds)"
  type        = number
  default     = 10
}