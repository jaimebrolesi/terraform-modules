# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  description = "The AWS region where infrastructure will be created"
  type        = string
  default     = "sa-east-1"
}