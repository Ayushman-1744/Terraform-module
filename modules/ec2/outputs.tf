output "public-ip" {
  value = aws_instance.ec2.public_ip
  description = "Public IP of the web server instance"
}
