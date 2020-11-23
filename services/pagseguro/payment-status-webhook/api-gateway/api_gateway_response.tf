resource "aws_api_gateway_method_response" "method_response" {
  for_each = var.response_mapping

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.notifications_path.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = each.key

  depends_on = [aws_api_gateway_integration.api_gateway_integration]
}

resource "aws_api_gateway_integration_response" "integration_response" {
  for_each = var.response_mapping

  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.notifications_path.id
  http_method       = aws_api_gateway_method.api_gateway_method.http_method
  status_code       = aws_api_gateway_method_response.method_response[each.key].status_code
  selection_pattern = each.value
}
