# modules/ec2-instance/variables.tf

variable "public_key_name" {
  description = "El nombre para la llave SSH."
  type        = string
}

variable "security_group_name" {
  description = "El nombre para el grupo de seguridad."
  type        = string
}

variable "environment" {
  description = "El entorno de despliegue para el módulo EC2."
  type        = string
}