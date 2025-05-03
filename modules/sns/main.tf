# Create an SNS topic
resource "aws_sns_topic" "my_topic" {
  name           = "my_sns_topic"
  display_name = "My SNS Topic"
}

# Create an email subscription
resource "aws_sns_topic_subscription" "email_subscriber" {
  topic_arn = aws_sns_topic.my_topic.arn  # Reference the ARN of the topic
  protocol   = "email"
  endpoint   = "ayushman1744@gmail.com" # Replace with your email address
}

### ------------------------------------------------------------------------------------------------------- ###
# Create sns topic using for each
resource "aws_sns_topic" "my_sns1_topic"{
  for_each = toset(["sam", "pam", "kim", "tom"])
  name = "cloud-user-${each.value}"
  tags = {
    name = "cloud-user-${each.value}"
  } 
}

# Create email subscription using for each 
resource "aws_sns_topic_subscription" "email_subscriber" {
  for_each = aws_sns_topic.my_sns1_topic
  topic_arn = each.value.arn  # Reference the ARN of the topic
  protocol   = "email"
  endpoint   = "ayushman1744@gmail.com" # Replace with your email address
}