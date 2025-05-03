resource "aws_ebs_volume" "sample" {
  availability_zone = "ap-south-1a"
  size              = 35
  type = "gp2"

  tags = {
    Name = "HelloWorld"
  }
}