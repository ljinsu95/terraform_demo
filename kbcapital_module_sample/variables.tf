variable "prefix" {
  description = "prefix"
  default     = "tf-vault-server"
}

#################################################
# 민감 변수 값
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS ACCESS KEY"
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS SECRET ACCESS KEY"
  sensitive   = true
}

variable "VAULT_LICENSE" {
  type        = string
  description = "License for the Vault"
  sensitive   = true
}
#################################################

#################################################
# AWS 리소스 참조 값
variable "aws_region" {
  description = "aws region"
  default     = "ca-central-1"
}

variable "aws_vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "aws_subnet_ids" {
  type        = list(string)
  description = "인스턴스 배포 대상 서브넷 ID 리스트"
}
#################################################

#################################################
# EC2 인스턴스 설정 값
variable "pem_key_name" {
  type        = string
  description = "ec2에 사용되는 pem key 명"
  default     = ""
}

variable "vault_version" {
  type        = string
  description = "Vault Version (예시 : x.y.z)"
  default     = "1.18.1"
}
#################################################
