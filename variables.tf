# variables.tf

variable "environment" {
  description = "El entorno de despliegue (aws o localstack)."
  type        = string
  default     = "localstack" # El valor por defecto es para tu entorno de desarrollo
}

variable "region" {
  description = "La región de AWS para el despliegue."
  type        = string
  default     = "us-east-1"
}