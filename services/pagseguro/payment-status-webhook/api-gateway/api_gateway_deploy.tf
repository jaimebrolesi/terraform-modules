resource "aws_api_gateway_deployment" "api_gateway_deploy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = var.environment

  triggers = {
    redeployment = sha1(join(",", list(
      jsonencode(aws_api_gateway_integration.api_gateway_integration),
    )))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.api_gateway_integration,
    aws_api_gateway_integration_response.http2xx,
    aws_api_gateway_integration_response.http400,
    aws_api_gateway_integration_response.http403,
    aws_api_gateway_integration_response.http404,
    aws_api_gateway_integration_response.http415,
    aws_api_gateway_integration_response.http5xx,
  ]
}
