# IAM Role for Lambda
resource "aws_iam_role" "lambda_iam_role" {
  name = "lambda-s3-dynamodb-role-${var.env_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for S3 and DynamoDB permissions
resource "aws_iam_policy" "lambda_s3_dynamodb_policy" {
  name        = "lambda_s3_dynamodb_policy-${var.env_name}"
  description = "Policy for Lambda to access S3 and DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}/${var.object_key}"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}"
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem"
        ],
        Resource = "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_table_name}*"
      }
    ]
  })
}

# Attach the policy to the IAM Role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_iam_role.name
  policy_arn = aws_iam_policy.lambda_s3_dynamodb_policy.arn
}

# Temporary allowing full access due to time constraint. 
# To be improved in future by adding policy of least privilege.
resource "aws_iam_role_policy_attachments_exclusive" "example" {
  role_name   = aws_iam_role.lambda_iam_role.name
  policy_arns = ["arn:aws:iam::aws:policy/CloudWatchFullAccess","arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess","arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}

# Data block for the current account ID
data "aws_caller_identity" "current" {}

# Outputs for debugging
output "lambda_role_arn" {
  value = aws_iam_role.lambda_iam_role.arn
}
output "policy_arn" {
  value = aws_iam_policy.lambda_s3_dynamodb_policy.arn
}
