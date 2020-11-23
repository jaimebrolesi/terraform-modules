# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name to use for the api gateway resources"
  type        = string
}

variable "description" {
  description = "The description to use for the api gateway resources"
  type        = string
}

variable "iam_role_arn" {
  description = "The iam role arn to use for the api gateway integration resources (e.g. arn:aws:iam::123456789012:role/YourRole)"
  type        = string
}

variable "queue_name" {
  description = "The name of the queue to use for the api gateway integration resources"
  type        = string
}

variable "aws_region" {
  description = "The aws region to use for the api gateway integration resources (e.g. us-east-1)"
  type        = string
}

variable "environment" {
  description = "The environment to use for the api gateway deployment resources (e.g. Should be stage or prod)"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "response_mapping" {
  description = "A map of integration responses status (e.g. {\"200\" = \"^2[0-9][0-9]\"})"
  type        = map

  default = {
    200 = "^2[0-9][0-9]",
    400 = "400",
    403 = "403",
    415 = "415",
    500 = "^5[0-9][0-9]"
  }
}
