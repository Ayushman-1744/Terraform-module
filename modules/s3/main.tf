resource "aws_s3_bucket" "bucket" {
  bucket = "${var.username}"

  tags = {
    Name        = "My bucket"
    Environment = "sample"
  }
  
}
