resource "aws_instance" "web" {
  ami                    = "ami-062f0cc54dbfd8ef1" #  Replace with the appropriate AMI ID for your region
  instance_type          = "t2.micro" # Or the instance type you want to use
  tags = {
    Name = "${var.username}"
  }

  # Add security groups, key pairs, etc. here as needed
}
resource "aws_ebs_volume" "my_volume" {
  size = 10
  type = "gp2"
  availability_zone = "ap-south-1b"
  # ... other volume configuration ...
}
# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "my_attachment" {
  instance_id = aws_instance.web.id
  volume_id = aws_ebs_volume.my_volume.id
  device_name = "/dev/sdh"
}