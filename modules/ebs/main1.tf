resource "aws_ebs_volume" "username" {
  availability_zone = "ap-south-1a"
  size              = var.size
  type = "gp2"

  tags = {
    Name = "${var.username}"
  }
}