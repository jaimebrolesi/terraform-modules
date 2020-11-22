data "template_file" "urlencoded_template" {
  template = file("${path.module}/templates/mapping-templates.vtl")
}

resource "aws_api_gateway_integration" "api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.notifications_path.id
  http_method             = aws_api_gateway_method.api_gateway_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  credentials             = var.iam_role_arn
  uri                     = "arn:aws:apigateway:${var.aws_region}:sqs:path/${var.queue_name}"
  passthrough_behavior    = "NEVER"

  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
  }

  request_templates = {
    "application/x-www-form-urlencoded" = data.template_file.urlencoded_template.rendered
  }

  depends_on = [aws_api_gateway_method.api_gateway_method]
}
