#!/bin/bas}

echo -e "\n\e[36m╔════════════════════════════════╗"
echo -e "║        🖥️  INFORMACIÓN DEL SISTEMA  ║"
echo -e "╚════════════════════════════════╝\e[0m\n"


echo "Sistema:             " "$(uname -s)"
echo "Distribución:        " "$(cat /etc/os-release | grep -i '^PRETTY_NAME=' | cut -d= -f2- | tr -d '"')"
echo "Arquitectura:        " "$(lscpu | grep -E "Architecture|Arquitectura" | awk '{print $2}')"

echo "Memoria RAM total:       " "$((($(grep MemTotal /proc/meminfo | awk '{print $2}') / 1024 / 1024)))G"
echo "Memoria RAM disponible:        " "$((($(grep MemAvailable /proc/meminfo | awk '{print $2}') / 1024 / 1024)))G"

echo "Entorno de escritorio" "$XDG_CURRENT_DESKTOP"
