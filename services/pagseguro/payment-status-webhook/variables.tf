# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "queue_name" {
  description = "The name to use for the queue resources"
  type        = string
}

variable "iam_role_name" {
  description = "The name to use for the iam role resources"
  type        = string
}

variable "api_gateway_name" {
  description = "The name to use for the api gateway resources"
  type        = string
}

variable "api_gateway_description" {
  description = "The description to use for the api gateway resources"
  type        = string
}

variable "aws_region" {
  description = "The aws region to use for the api gateway integration resources"
  type        = string
}

variable "environment" {
  description = "The environment to use for the api gateway deployment resources (e.g. Should be stage or prod)"
  type        = string
}
