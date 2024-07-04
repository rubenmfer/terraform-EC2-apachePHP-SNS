provider "aws" {
 region = var.region
}

resource "aws_sns_topic" "topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "topic_email_subscription" {
    topic_arn   = aws_sns_topic.topic.arn
    protocol    = "email"
    endpoint    = var.email
}