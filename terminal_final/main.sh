#!/bin/bash

# bloqueo de Ctrl+C y Ctrl+Z
trap '' SIGINT
trap '' SIGTSTP

# colores
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m'

while true; do
  USER=$(whoami)
  CURRENT_DIR=$(pwd)
  echo -e "\n${GREEN}${USER}${NC}@${BLUE}${CURRENT_DIR}${NC} ➜ Escribe un comando ('ayuda' para ver lista)"
  echo -n "➜ "
  read input
  input=${input,,}  

  case $input in
    ayuda) bash ayuda.sh ;;
    infosis) bash infosis.sh ;;
    fecha) bash fecha.sh ;;
    buscar*) bash buscar.sh $input ;;
    creditos) bash creditos.sh ;;
    juego) bash ./ahorcado.sh ;;
    mp3) bash ./mp3.sh ;;
    salir) bash salir.sh && exit 0 ;;
    *)
      if command -v "$input" >/dev/null 2>&1; then
        eval "$input"
      else
        echo "Error: $input"
      fi
      ;;
  esac
done

