#!/bin/bash

# Actualizar la lista de paquetes
sudo dnf update -y

# Instalar Nginx
sudo dnf install nginx -y

# Iniciar el servicio de Nginx
sudo systemctl start nginx