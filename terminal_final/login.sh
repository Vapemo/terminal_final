#!/bin/bash

clear
echo " Bienvenido a Terminal Final"
read -p "Ingrese su nombre de usuario: " user

if [[ $user == "dma" || $user == "leo" ]]; then
    echo "¡Hola, $user! Acceso permitido."
    sleep 1
    bash main.sh
else
    echo " Usuario incorrecto. Acceso denegado."
    exit 1
fi
