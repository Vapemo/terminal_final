#!/bin/bash

echo -e "\n\e[36m╔════════════════════════════╗"
echo -e "║        🔍 BUSCAR ARCHIVOS     ║"
echo -e "╚════════════════════════════╝\e[0m\n"


echo "Directorio: "
read ruta

echo "Archivo: "
read archivo

if [ -e "$ruta/$archivo"  ]; then
    echo -e "\n${v}El archivo se ha encontrado."

elif [ -e "$HOME/$ruta/$archivo" ]; then
    echo -e "\n${v}El archivo se ha encontrado."

else
    echo -e "\n${r}El archivo no se ha encontrado."
fi
