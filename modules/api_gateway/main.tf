resource "aws_apigatewayv2_api" "hello_lambda" {
  name          = "hello_lambda_gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "hello_lambda" {
  api_id = aws_apigatewayv2_api.hello_lambda.id

  name        = "development"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.hello_api_gateway.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "hello_lambda" {
  api_id = aws_apigatewayv2_api.hello_lambda.id

  integration_uri    = var.integration_uri
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "hello_lambda" {
  api_id = aws_apigatewayv2_api.hello_lambda.id

  route_key          = "GET /hello"
  target             = "integrations/${aws_apigatewayv2_integration.hello_lambda.id}"
  authorizer_id      = aws_apigatewayv2_authorizer.api_geteway_autorizer.id
  authorization_type = "JWT"
  depends_on = [
    aws_apigatewayv2_authorizer.api_geteway_autorizer
  ]
}

resource "aws_cloudwatch_log_group" "hello_api_gateway" {
  name = "/aws/hello_api_gateway/${aws_apigatewayv2_api.hello_lambda.name}"

  retention_in_days = 30
}

resource "aws_lambda_permission" "hello_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.hello_lambda.execution_arn}/*/*"
}

resource "aws_apigatewayv2_authorizer" "api_geteway_autorizer" {
  api_id           = aws_apigatewayv2_api.hello_lambda.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "hello-api-authorizer"

  jwt_configuration {
    audience = var.audience
    issuer   = var.authorizer_issuer
  }
}
