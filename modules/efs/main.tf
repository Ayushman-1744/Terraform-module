#resource "aws_efs_file_system" "file" {
 # creation_token = "${var.name}"

  #tags = {
   # Name = "MyProduct"
  #}
#}

## Connect EFS to EC2 
# VPC (use default)

data "aws_vpc" "default" {
  default = true
}

# Subnets (use default)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group for EFS and EC2
resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Allow NFS traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EFS File System
resource "aws_efs_file_system" "efs" {
  creation_token = "efs-for-ec2"
  encrypted      = true

  tags = {
    Name = "MyEFS"
  }
}

# EFS Mount Targets (one in each subnet)
resource "aws_efs_mount_target" "efs_mount" {
  for_each = toset(data.aws_subnets.default.ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs_sg.id]
}

# EC2 Instance
resource "aws_instance" "ec2" {
  ami                         = "ami-0f1dcc636b69a6438"#var.ami_id
  instance_type               = "t2.micro"#var.instance_type
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.efs_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum install -y amazon-efs-utils
              mkdir -p /mnt/efs
              mount -t efs ${aws_efs_file_system.efs.id}:/ /mnt/efs
              echo "${aws_efs_file_system.efs.id}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab
              EOF

  tags = {
    Name = "EC2-With-EFS"
  }
}
