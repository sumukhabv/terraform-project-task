resource "aws_apigatewayv2_api" "example" {
  name          = var.api_name
  protocol_type = "HTTP"
}

