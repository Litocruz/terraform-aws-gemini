#!/bin/bash
# Actualizar la lista de paquetes
sudo apt-get update -y

# Instalar Nginx
sudo apt-get install nginx -y

# Iniciar el servicio de Nginx
sudo systemctl start nginx