resource "aws_efs_file_system" "file" {
  creation_token = "my-file"

  tags = {
    Name = "MyProduct"
  }
}