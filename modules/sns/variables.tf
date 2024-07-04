variable "region" {
    type        = string
    default     = "us-east-1"
    description = "aws region"
}

variable "sns_topic_name" {
    type        = string
    description = "name sns topic"
}

variable "email" {
    type        = string
    description = "email subscription topic sns"
}