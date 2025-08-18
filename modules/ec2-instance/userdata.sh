#!/bin/bash

# Actualizar la lista de paquetes
sudo dnf update -y

# Instalar Nginx
sudo dnf install nginx -y

# Iniciar el servicio de Nginx
sudo systemctl start nginx

# La contraseña es inyectada por Terraform
password="${password}"

# Usar la contraseña (simulación)
echo "La contraseña obtenida es: $password" >> /var/log/userdata.log