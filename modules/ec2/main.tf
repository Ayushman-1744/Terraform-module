resource "aws_instance" "web" {
  ami           = "ami-0f1dcc636b69a6438"  # This Ami is for Mumbai region- "ap-south-1"Make sure to use the correct AMI for the specific region.
  instance_type = "t2.micro"

  tags = {
    Name = "${var.username}}"
  }
}


# 1. Create S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  force_destroy = true

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

# 2. Create IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

# 3. Attach S3 Access Policy to IAM Role
resource "aws_iam_role_policy" "s3_access" {
  name = "s3-access-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      Resource = [
        aws_s3_bucket.bucket.arn,
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }]
  })
}

# 4. Create Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-access-profile"
  role = aws_iam_role.ec2_role.name
}

# 5. Create EC2 Instance
resource "aws_instance" "ec2" {
  ami           = "ami-0f1dcc636b69a6438" #var.ami.id
  instance_type = "t2.micro" #var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "S3ConnectedEC2"
  }
}
