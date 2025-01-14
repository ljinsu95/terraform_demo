# Provider 구성 설정
provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "vault" {
  source  = "app.terraform.io/insideinfo_jinsu/vault/aws"
  version = "1.0.1"
  # insert required variables here
  VAULT_LICENSE  = var.VAULT_LICENSE
  aws_vpc_id     = var.aws_vpc_id
  aws_subnet_ids = var.aws_subnet_ids
  pem_key_name   = var.pem_key_name
  vault_version  = var.vault_version
}
