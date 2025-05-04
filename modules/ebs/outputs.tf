output "ebs_volume_size" {
  description = "Size of the EBS volume in GiB"
  value       = aws_ebs_volume.username.size
}

output "ebs_volume_arn" {
  description = "ARN of the EBS volume"
  value       = aws_ebs_volume.username.arn
}