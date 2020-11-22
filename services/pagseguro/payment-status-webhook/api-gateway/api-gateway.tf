resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.name
  description = var.description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api_path" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "api"
}

resource "aws_api_gateway_resource" "v1_path" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.api_path.id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "payments_path" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.v1_path.id
  path_part   = "payments"
}

resource "aws_api_gateway_resource" "notifications_path" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.payments_path.id
  path_part   = "notifications"
}

resource "aws_api_gateway_method" "api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.notifications_path.id
  http_method   = "POST"
  authorization = "NONE"
}
