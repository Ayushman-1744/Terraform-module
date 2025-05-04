output "vpc_arn" {
  description = "ARN of the created VPC"
  value       = aws_vpc.main.arn
}
output "subnet_arn" {
  description = "ARN of the created Subnet"
  value       = aws_subnet.public_1.arn
}

output "igw_arn" {
  description = "ARN of the created Internet Gateway"
  value       = aws_internet_gateway.igw.arn
}