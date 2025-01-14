# 인스턴스 pulbic ip 출력
output "vault_public_ip" {
  value = module.vault.vault_public_ip
}
output "sg_vault_server" {
  value = module.vault.sg_vault_server
}
output "aws_subnets" {
  value = module.vault.aws_subnets
}
