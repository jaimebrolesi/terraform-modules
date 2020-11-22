output "api_gateway_url" {
  value       = aws_api_gateway_deployment.api_gateway_deploy.invoke_url
  description = "The url of the api gateway"
}
