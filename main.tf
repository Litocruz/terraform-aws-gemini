# main.tf (continuación)

module "web_server" {
  source                = "./modules/ec2-instance"
  public_key_name       = "mi-llave-del-servidor-web"
  security_group_name   = "servidor-web-sg"
  environment         = var.environment  # Aquí pasas la variable al módulo
}

output "public_ip_del_servidor" {
  description = "La IP pública del servidor web creado por el módulo EC2."
  value       = module.web_server.public_ip
}

output "public_dns" {
  description = "DNS del servidor web creado por el módulo EC2."
  value = module.web_server.public_dns
}