resource "aws_api_gateway_method_response" "http200" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.notifications_path.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = 200
}

resource "aws_api_gateway_method_response" "http400" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.notifications_path.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = 400
}

resource "aws_api_gateway_method_response" "http403" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.notifications_path.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = 403
}

resource "aws_api_gateway_method_response" "http404" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.notifications_path.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = 404
}

resource "aws_api_gateway_method_response" "http415" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.notifications_path.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = 415
}

resource "aws_api_gateway_method_response" "http500" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.notifications_path.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method
  status_code = 500
}

resource "aws_api_gateway_integration_response" "http2xx" {
  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.notifications_path.id
  http_method       = aws_api_gateway_method.api_gateway_method.http_method
  status_code       = aws_api_gateway_method_response.http200.status_code
  selection_pattern = "^2[0-9][0-9]"

  depends_on = [aws_api_gateway_integration.api_gateway_integration]
}

resource "aws_api_gateway_integration_response" "http400" {
  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.notifications_path.id
  http_method       = aws_api_gateway_method.api_gateway_method.http_method
  status_code       = aws_api_gateway_method_response.http400.status_code
  selection_pattern = aws_api_gateway_method_response.http400.status_code

  depends_on = [aws_api_gateway_integration.api_gateway_integration]
}

resource "aws_api_gateway_integration_response" "http403" {
  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.notifications_path.id
  http_method       = aws_api_gateway_method.api_gateway_method.http_method
  status_code       = aws_api_gateway_method_response.http403.status_code
  selection_pattern = aws_api_gateway_method_response.http403.status_code

  depends_on = [aws_api_gateway_integration.api_gateway_integration]
}

resource "aws_api_gateway_integration_response" "http404" {
  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.notifications_path.id
  http_method       = aws_api_gateway_method.api_gateway_method.http_method
  status_code       = aws_api_gateway_method_response.http404.status_code
  selection_pattern = aws_api_gateway_method_response.http404.status_code

  depends_on = [aws_api_gateway_integration.api_gateway_integration]
}

resource "aws_api_gateway_integration_response" "http415" {
  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.notifications_path.id
  http_method       = aws_api_gateway_method.api_gateway_method.http_method
  status_code       = aws_api_gateway_method_response.http415.status_code
  selection_pattern = aws_api_gateway_method_response.http415.status_code

  depends_on = [aws_api_gateway_integration.api_gateway_integration]
}

resource "aws_api_gateway_integration_response" "http5xx" {
  rest_api_id       = aws_api_gateway_rest_api.api_gateway.id
  resource_id       = aws_api_gateway_resource.notifications_path.id
  http_method       = aws_api_gateway_method.api_gateway_method.http_method
  status_code       = aws_api_gateway_method_response.http500.status_code
  selection_pattern = "^5[0-9][0-9]"

  depends_on = [aws_api_gateway_integration.api_gateway_integration]
}
