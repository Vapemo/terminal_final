#!/bin/bash

# Colores
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
GREEN="\e[32m"
RESET="\e[0m"

# Verificar si mpg123 está instalado
if ! command -v mpg123 &>/dev/null; then
    echo -e "${YELLOW}Instalando 'mpg123'...${RESET}"
    sudo apt update && sudo apt install -y mpg123 || {
        echo -e "${RED}No se pudo instalar mpg123.${RESET}"
        exit 1
    }
fi

# Carpeta de música fija
music_dir="$(dirname "$0")/../recursos/musica"

# Validar existencia
if [ ! -d "$music_dir" ]; then
    echo -e "${RED}La carpeta de música no existe: $music_dir${RESET}"
    exit 1
fi

# Buscar canciones .mp3
mapfile -t canciones < <(find "$music_dir" -type f -iname "*.mp3")
if [ ${#canciones[@]} -eq 0 ]; then
    echo -e "${RED}No hay canciones en $music_dir${RESET}"
    exit 1
fi

# Menú
while true; do
    clear
    echo -e "${CYAN} Canciones disponibles:${RESET}"
    for i in "${!canciones[@]}"; do
        echo -e "${YELLOW}$((i+1))${RESET}) $(basename "${canciones[$i]}")"
    done
    echo -e "${YELLOW}q${RESET}) Salir"

    read -rp "Selecciona número o 'q': " opcion
    if [[ "$opcion" == "q" ]]; then
        echo -e "${GREEN}Saliendo del reproductor.${RESET}"
        break
    fi

    if [[ "$opcion" =~ ^[0-9]+$ ]] && (( opcion >= 1 && opcion <= ${#canciones[@]} )); then
        archivo="${canciones[$((opcion-1))]}"
        echo -e "${GREEN}Reproduciendo:${RESET} $(basename "$archivo")"
        mpg123 "$archivo"
        read -n1 -rsp $'\nPresiona una tecla para continuar...\n'
    else
        echo -e "${RED}Opción no válida.${RESET}"
        sleep 1
    fi
done
