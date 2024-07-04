variable "ami" {
    type        = string
    description = "EC2 AMI"
}

variable "instance_type" {
    type        = string
    description = "AWS Type of instance"
}

variable "key_name" {
    type        = string
    description = "AWS Key Name"
}

variable "ssh_user" {
    type        = string
    description = "User system SSH"
}

variable "ssh_fname" {
    type        = string
    description = "Filename key ssh"
}

variable "script" {
    type        = string
    description = "Filename install service"
}

variable "sns_topic_arn" {
    type        = string
    description = "SNS topic ARN"
}