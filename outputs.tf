output "lambda_bucket_name" {
  description = "S3 bucket to store function code"
  value       = aws_s3_bucket.lambda_bucket.id
}

output "function_name" {
  value = module.lambda.function_name
}

output "base_url" {
  value = module.api_gateway.base_url
}
