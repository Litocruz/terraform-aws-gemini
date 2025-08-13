output "public_ip" {
  description = "La dirección IP pública de la instancia EC2."
  value       = aws_instance.devops_instance.public_ip
}

output "public_dns" {
  description = "El DNS de la instancia EC2."
  value       = aws_instance.devops_instance.public_dns
}