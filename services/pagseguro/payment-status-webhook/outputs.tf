output "queue_name" {
  value       = module.simple_queue.name
  description = "The name of the queue that Api Gateway sends the payments updates"
}

output "iam_role_arn" {
  value       = module.iam_role.role.arn
  description = "The arn of iam role used by Api Gateway Integration"
}
