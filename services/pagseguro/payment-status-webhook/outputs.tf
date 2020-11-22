output "queue_name" {
  value       = module.simple_queue.queue_name
  description = "The name of the queue that Api Gateway sends the payments updates"
}

output "iam_role_arn" {
  value       = module.iam_role.iam_role_arn
  description = "The arn of iam role used by Api Gateway Integration"
}
