output "instance_id" {
       description = "The ID of the EC2 instance."
       value       = aws_instance.web
     }

output "instance_public_ip" {
       description = "The public IP address of the EC2 instance."
       value       = aws_instance.web.public_ip
     }

output "ebs_volume_id" {
       description = "The ID of the EBS volume."
       value       = aws_ebs_volume.my_volume.id
     }