resource "aws_efs_file_system" "file" {
  creation_token = "${var.name}"

  tags = {
    Name = "MyProduct"
  }
}