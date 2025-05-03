# Create an SNS topic
#resource "aws_sns_topic" "my_sns_topic" {
 # name = "my-sns-topic" # Replace with your desired topic name
#}
# Create SQS queue
#resource "aws_sqs_queue" "my_sqs_queue" {
 # name = "my-sqs-queue" # Replace with your desired queue name
#}
# Link to SNS topic
#resource "aws_sns_topic_subscription" "my_sns_sqs_subscription" {
 # topic_arn = aws_sns_topic.my_sns_topic.arn # Link to the SNS topic
  #protocol    = "sqs" # Specifies the protocol (SQS)
  #endpoint    = aws_sqs_queue.my_sqs_queue.arn # Link to the SQS queue
#}
### -------------------------------------------------------------------------------------------------- ###
# Create SNS topic
resource "aws_sns_topic" "my_sns1_topic" {
  for_each = toset(["dev", "test", "prod", "deploy"])

  name = "cloud-user-${each.key}"
  tags = {
    name = "cloud-user-${each.key}"
  }
}
# Create SQS Queue
resource "aws_sqs_queue" "my_queue" {
  for_each = toset(["dev", "test", "prod", "deploy"])
  name = "cloud-user-queue-${each.key}"
}
# Link to SNS topic
resource "aws_sns_topic_subscription" "sqs_subscription" {
  for_each = toset(["dev", "test", "prod", "deploy"])

  topic_arn = aws_sns_topic.my_sns1_topic[each.key].arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.my_queue[each.key].arn
}