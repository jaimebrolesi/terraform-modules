output "queue_name" {
  value       = aws_sqs_queue.queue.name
  description = "The name of simples queue"
}

output "queue_arn" {
  value       = aws_sqs_queue.queue.arn
  description = "The arn of simples queue"
}
