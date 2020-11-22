terraform {
  required_version = ">= 0.13.5"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE DEAD LETTER QUEUE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_sqs_queue" "dlq_queue" {
  name                      = upper("DLQ_${var.name}")
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SIMPLE QUEUE ATTACHED TO DLQ 
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_sqs_queue" "queue" {
  name                      = upper(var.name)
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq_queue.arn
    maxReceiveCount     = var.max_receive_count
  })
}
