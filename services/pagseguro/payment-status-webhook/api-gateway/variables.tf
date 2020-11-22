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
  description = "The iam role arn to use for the api gateway integration resources"
  type        = string
}

variable "queue_name" {
  description = "The name of the queue to use for the api gateway integration resources"
  type        = string
}

variable "aws_region" {
  description = "The aws region to use for the api gateway integration resources"
  type        = string
  default     = "sa-east-1"
}
