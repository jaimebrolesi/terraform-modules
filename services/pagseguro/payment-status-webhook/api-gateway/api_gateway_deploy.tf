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

  depends_on = [aws_api_gateway_integration_response.integration_response]
}
