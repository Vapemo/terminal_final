#!/bin/bash

# ruta de la musica
MUSIC_DIR="recursom"

# muestra un menú
mostrar_menu() {
    clear
    echo "========================="
    echo "  REPRODUCTOR MP3 "
    echo "========================="
    echo "1) Seleccionar carpeta de música"
    echo "2) Ver lista de canciones"
    echo "3) Reproducir canción"
    echo "4) Siguiente canción"
    echo "5) Canción anterior"
    echo "6) Salir"
}

# variables para el  estado
canciones=()
indice_actual=0

# verifica que mpg123 esté instalado
verificar_mpg123() {
    if ! command -v mpg123 &>/dev/null; then
        echo "El programa 'mpg123' no está instalado."
        read -p "¿Deseas instalarlo ahora? (s/n): " respuesta
        if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
            sudo apt update && sudo apt install -y mpg123
            if ! command -v mpg123 &>/dev/null; then
                echo "Error: No se pudo instalar 'mpg123'. Saliendo..."
                exit 1
            fi
        else
            echo "No se puede continuar sin 'mpg123'. Saliendo..."
            exit 1
        fi
    fi
}

# toma la  música desde una carpeta
cargar_musica() {
    read -p "Introduce la ruta de la carpeta con música: " MUSIC_DIR
    if [ -d "$MUSIC_DIR" ]; then
        canciones=("$(find "$MUSIC_DIR" -type f -name "*.mp3" 2>/dev/null)")
        if [ ${#canciones[@]} -eq 0 ]; then
            echo "No se encontraron archivos MP3 en la carpeta."; sleep 2
        else
            echo "Canciones cargadas correctamente."; sleep 2
        fi
    else
        echo "La carpeta especificada no existe."; sleep 2
    fi
}

# muestra las  canciones
listar_canciones() {
    if [ ${#canciones[@]} -eq 0 ]; then
        echo "No hay canciones cargadas."
    else
        echo "Lista de canciones:"
        for i in "${!canciones[@]}"; do
            echo "$((i + 1))) $(basename "${canciones[i]}")"
        done
    fi
    read -p "Presiona [Enter] para continuar..."
}

# reproduce la  canción
reproducir_cancion() {
    if [ ${#canciones[@]} -eq 0 ]; then
        echo "No hay canciones cargadas."; sleep 2
        return
    fi
    echo "Reproduciendo: $(basename "${canciones[indice_actual]}")"
    mpg123 "${canciones[indice_actual]}" &>/dev/null &
}

# detiene la canción
parar_cancion() {
    pkill mpg123 2>/dev/null
}

#  cambia a la siguiente canción
siguiente_cancion() {
    if [ ${#canciones[@]} -eq 0 ]; then
        echo "No hay canciones cargadas."; sleep 2
        return
    fi
    parar_cancion
    indice_actual=$(( (indice_actual + 1) % ${#canciones[@]} ))
    reproducir_cancion
}

#  cambia a la canción anterior
anterior_cancion() {
    if [ ${#canciones[@]} -eq 0 ]; then
        echo "No hay canciones cargadas."; sleep 2
        return
    fi
    parar_cancion
    indice_actual=$(( (indice_actual - 1 + ${#canciones[@]}) % ${#canciones[@]} ))
    reproducir_cancion
}

# verifica  que mpg123 esté instalado antes de iniciar
verificar_mpg123

# bucle principal
while true; do
    mostrar_menu
    read -p "Selecciona una opción: " opcion

    case $opcion in
        1)
            cargar_musica
            ;;
        2)
            listar_canciones
            ;;
        3)
            parar_cancion
            reproducir_cancion
            ;;
        4)
            siguiente_cancion
            ;;
        5)
            anterior_cancion
            ;;
        6)
            parar_cancion
            echo "Salida..."
            exit 0
            ;;
        *)
            echo "Opción no válida."; sleep 2
            ;;
    esac

done

