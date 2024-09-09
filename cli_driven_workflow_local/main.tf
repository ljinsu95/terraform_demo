# Terraform 연동 설정 (terraform login 필요)
terraform {
  cloud {

    organization = "insideinfo-test"

    workspaces {
      name = "cli_local"
    }
  }
}

# Provider 구성 설정
provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# 아마존 리눅스 2 이미지 조회
### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }
}

# 인스턴스(Vault Server) 생성
### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "vault_amz2" {
  count = 3

  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  subnet_id              = "subnet-052b5eae8cc4f2515"
  vpc_security_group_ids = toset([aws_security_group.vault_server.id])
  key_name               = var.pem_key_name
  tags = {
    Name = "${var.prefix}_Vault_${count.index}"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = "10"
    tags = {
      Name = "${var.prefix}_Vault_Volume_${count.index}"
    }
  }

}

# Security Group 생성
### https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "vault_server" {
  name   = "${var.prefix}_sg_vault_server"
  vpc_id = "vpc-0f8af692fead0eaea"

  # 22 : ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 8200 : vault server
  # 8201 : vault cluster 내부 통신
  ingress {
    from_port   = 8200
    to_port     = 8201
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_sg_vault_server"
  }
}
