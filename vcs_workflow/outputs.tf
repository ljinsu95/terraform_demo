# 인스턴스 pulbic ip 출력
output "ec2_public_ip" {
  value = aws_instance.vault_amz2.*.public_ip
}
