#!/bin/bash

# bloqueo de  Ctrl+C y Ctrl+Z
trap '' SIGINT
trap '' SIGTSTP

# personalización
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' 

while true; do
  USER=$(whoami)
  CURRENT_DIR=$(pwd)
  echo -e "\n${GREEN}${USER}${NC}@${BLUE}${CURRENT_DIR}${NC} ➜ Escribe un comando ('ayuda' para ver lista)"
  echo -n "➜ "
  read input

  case $input in
    ayuda) bash comandos/ayuda.sh ;;
    infosis) bash comandos/infosis.sh ;;
    fecha) bash comandos/fecha.sh ;;
    buscar*) bash comandos/buscar.sh $input ;;
    creditos) bash comandos/creditos.sh ;;
    juego) bash comandos/juego.sh ;;
    mp3) bash comandos/mp3.sh ;;
    salir) bash comandos/salir.sh && exit 0 ;;
    *) echo " Comando incorrecto: $input" ;; #listado (ayuda,infosis,fecha,buscar,creditos(nuestros nombres),juego ,reproductor,salida )
  esac
done

