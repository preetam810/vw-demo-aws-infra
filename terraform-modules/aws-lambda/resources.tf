# Define Variables
# Lambda Module
module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.8.1"  

  function_name = var.lambda_function_name
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout

  create_package = false
  s3_existing_package = {
    bucket = var.lambda_code_s3_bucket
    key    = "${var.build_repository_type}/${var.build_version_to_deploy}"
  }
  create_role     = false
  lambda_role = "arn:aws:iam::730335502100:role/lambda-s3-dynamodb-role-${var.env_name}"

  tags = var.shared_tags
}

# Define the S3 bucket
resource "aws_s3_bucket" "data_bucket" {
  bucket = "vw-demo-${var.env_name}-730335502100-data"
  tags = var.shared_tags
}

## Add S3 trigger

# Create S3 bucket notification to trigger Lambda on specific events
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.data_bucket.id

  lambda_function {
    lambda_function_arn = module.lambda_function.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }

  # Ensure Lambda permissions are added before creating the notification
  depends_on = [aws_lambda_permission.allow_s3_invoke]
}

# Grant the S3 bucket permission to invoke the Lambda function
resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "lambda-s3-dynamodb-${var.env_name}"
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.data_bucket.arn
}

# Output the Lambda function ARN
output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = module.lambda_function.lambda_function_arn
}
