#!/bin/bash

# acceso al  usuario1

clear
echo "=============================="
echo "   TERMINAL FINAL"
echo "=============================="
echo " Ingresar como: usuario1"
echo

read -s -p "Contraseña: " password
echo

# se valida con sudo
echo "$password" | sudo -S -u usuario1 true &>/dev/null

if [[ $? -ne 0 ]]; then
    echo " Contraseña incorrecta."
    exit 1
fi

echo " Acceso concedido a usuario1"
sleep 1

# ejecuta  terminal principal
bash "$(dirname "$0")/main.sh"

