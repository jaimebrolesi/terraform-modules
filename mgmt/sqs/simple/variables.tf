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
  description = "The name to use for the queue resources"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "delay_seconds" {
  description = "The delayed seconds to delivery a message to consumer (e.g. Should be between 0 seconds and 15 minutes)"
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "The maximum size of a message in bytes (e.g. Should be between 1 KB and 256 KB)"
  type        = number
  default     = 262144
}

variable "message_retention_seconds" {
  description = "The amount of time in seconds that AWS retains a message to be consumed (e.g. Should be between 1 minute and 14 days)"
  type        = number
  default     = 345600
}

variable "receive_wait_time_seconds" {
  description = "The maximum amount of time in seconds that polling will wait for messages to become available to receive (e.g. Should be between 0 and 20 seconds)"
  type        = number
  default     = 20
}

variable "max_receive_count" {
  description = "The maximum receives times a message will be proccessed before it goes to dead letter queue (e.g. 3 times)"
  type        = number
  default     = 3
}
