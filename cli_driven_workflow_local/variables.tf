variable "prefix" {
  type        = string
  default     = "cli_local"
  description = "prefix"
}

variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS ACCESS KEY"
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "AWS SECRET ACCESS KEY"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  default     = "ca-central-1"
  description = "aws region"
}

variable "pem_key_name" {
  type        = string
  default     = "jinsu"
  description = "ec2에 사용되는 pem key 명"
}
