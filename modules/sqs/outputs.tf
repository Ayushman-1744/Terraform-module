output "sns_topic_arns" {
  value = { for k, topic in aws_sns_topic.my_sns1_topic : k => topic.arn }
  description = "ARNs of the SNS topics created."
}
