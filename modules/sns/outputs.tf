output "sns_topic_arn" {
  value       = aws_sns_topic.topic.arn
  description = "SNS topic ARN"
}