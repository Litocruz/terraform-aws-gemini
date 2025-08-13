# security-group.tf

resource "aws_security_group" "web_sg" {
  name        = var.security_group_name
  description = "Grupo de seguridad para permitir el tráfico web (HTTP)"

  # Regla de entrada (Ingress)
  ingress {
    description = "Allow_HTTP_traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Esta regla permite el acceso desde cualquier dirección IPv4 (0.0.0.0/0)
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida (Egress)
  egress {
    description = "Allow_all_traffic_to_internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 significa todos los protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}