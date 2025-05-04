output "user_arn" {
  value = aws_iam_user.my_user.arn
}

output "group_users" {
  description = "List of IAM users in IAM group"
  value       = aws_iam_user_group_membership.example_membership.user
}

output "group_name" {
  description = "IAM group name"
  value       = aws_iam_group.my_group.name
}
output "group_arn" {
    value = aws_iam_group.my_group.arn
}