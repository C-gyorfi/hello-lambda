output "lambda_bucket_name" {
  description = "S3 bucket to store function code"
  value = aws_s3_bucket.lambda_bucket.id
}

output "function_name" {
  description = "My lambda function name"

  value = aws_lambda_function.hello_lambda.function_name
}

output "base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.hello_lambda.invoke_url
}