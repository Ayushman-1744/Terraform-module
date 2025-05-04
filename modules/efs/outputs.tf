output "efs_file_system_arn" {
  value = aws_efs_file_system.file.arn
  description = "The ARN of the EFS file system"
}

output "efs_file_system_id" {
  value = aws_efs_file_system.file.id
  description = "The ID of the EFS file system"
}
output "efs_file_system_size_in_bytes" {
  value = aws_efs_file_system.file.size_in_bytes
  description = "The size of the EFS file system in bytes"
}