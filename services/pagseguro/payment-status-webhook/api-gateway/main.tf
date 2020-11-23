# ------------------------------------------------------------------------------
# CREATE THE API GATEWAY
# ------------------------------------------------------------------------------

resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.name
  description = var.description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# ------------------------------------------------------------------------------
# CREATE THE API GATEWAY PATHS
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# CREATE THE API GATEWAY METHOD
# ------------------------------------------------------------------------------

resource "aws_api_gateway_method" "api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.notifications_path.id
  http_method   = "POST"
  authorization = "NONE"
}

# ------------------------------------------------------------------------------
# CREATE THE API GATEWAY INTEGRATION METHOD
# ------------------------------------------------------------------------------

data "template_file" "urlencoded_template" {
  template = file("${path.module}/templates/mapping-templates.vtl")
}

data "aws_region" "current" {}

resource "aws_api_gateway_integration" "api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.notifications_path.id
  http_method             = aws_api_gateway_method.api_gateway_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  credentials             = var.iam_role_arn
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:sqs:path/${var.queue_name}"
  passthrough_behavior    = "NEVER"

  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
  }

  request_templates = {
    "application/x-www-form-urlencoded" = data.template_file.urlencoded_template.rendered
  }

  depends_on = [aws_api_gateway_method.api_gateway_method]
}

# ------------------------------------------------------------------------------
# CREATE THE API GATEWAY INTEGRATION RESPONSE CODE AND PATTERNS
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# CREATE THE API GATEWAY INTEGRATION DEPLOY
# ------------------------------------------------------------------------------

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
