output "iam_role_arn" {
  value       = aws_iam_role.role.arn
  description = "The arn of iam role"
}
