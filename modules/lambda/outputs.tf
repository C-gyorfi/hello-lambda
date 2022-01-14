output "function_name" {
  description = "My lambda function name"

  value = aws_lambda_function.hello_lambda.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.hello_lambda.invoke_arn
}