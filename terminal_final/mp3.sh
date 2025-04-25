#!/bin/bash

# ruta de  la carpeta de música
MUSIC_DIR="$(dirname "$0")/../recursom"

# verificar si esta mpg123 
if ! command -v mpg123 &>/dev/null; then
    echo "El programa 'mpg123' no está instalado."
    read -p "¿Deseas instalarlo ahora? [s/n]: " respuesta
    if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
        sudo apt update && sudo apt install -y mpg123
    else
        echo "No se puede continuar sin 'mpg123'."
        exit 1
    fi
fi

#  carpeta y se carga las canciones
if [ ! -d "$MUSIC_DIR" ]; then
    echo " Carpeta '$MUSIC_DIR' no encontrada."
    exit 1
fi

mapfile -t canciones < <(find "$MUSIC_DIR" -type f -iname "*.mp3")

if [[ ${#canciones[@]} -eq 0 ]]; then
    echo " No hay canciones MP3 en '$MUSIC_DIR'"
    exit 1
fi

indice=0

mostrar_menu() {
    echo
    echo "======= REPRODUCTOR MP3 ======="
    echo "1. Ver canciones"
    echo "2. Reproducir"
    echo "3. Siguiente"
    echo "4. Anterior"
    echo "5. Salir"
    echo
}

ver_canciones() {
    echo "Canciones disponibles:"
    for i in "${!canciones[@]}"; do
        actual=""
        if [[ "$i" -eq "$indice" ]]; then
            actual=" <-- Actual"
        fi
        echo " [$((i+1))] $(basename "${canciones[$i]}")$actual"
    done
}

reproducir_actual() {
    echo
    echo " Reproduciendo: $(basename "${canciones[$indice]}")"
    mpg123 "${canciones[$indice]}"
}

siguiente_cancion() {
    ((indice++))
    if (( indice >= ${#canciones[@]} )); then
        indice=0
    fi
    echo "Siguiente: $(basename "${canciones[$indice]}")"
}

anterior_cancion() {
    ((indice--))
    if (( indice < 0 )); then
        indice=$((${#canciones[@]} - 1))
    fi
    echo "Anterior: $(basename "${canciones[$indice]}")"
}

# menú
while true; do
    mostrar_menu
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1)
            ver_canciones
            ;;
        2)
            reproducir_actual
            ;;
        3)
            siguiente_cancion
            ;;
        4)
            anterior_cancion
            ;;
        5)
            echo "Saliendo del reproductor..."
            break
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
    echo
    read -n1 -rsp $'Presiona una tecla para continuar...\n'
done

