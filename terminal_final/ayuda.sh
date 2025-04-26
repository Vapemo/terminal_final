#!/bin/bash

# colores
MAGENTA='\033[1;35m'
AZUL='\033[1;34m'
VERDE='\033[1;32m'
NC='\033[0m' 

printf "\n\n"
echo -e "\n\e[36m╔════════════════════════════════╗"
echo -e "║         📖 AYUDA DEL SISTEMA     ║"
echo -e "╚════════════════════════════════╝\e[0m\n"
printf "\n\n"
echo -e "${VERDE}Comando           ${AZUL}Descripción${NC}"
echo -e "${MAGENTA}-------------------------------------------------------------------${NC}"
echo -e "${VERDE}infosis${NC}           ${AZUL}Información del sistema que muestra: Memoria RAM - Arquitectura del sistema - Version del SO${NC}"
echo -e "${MAGENTA}---------------------------------------------------------------------${NC}"
echo -e "${VERDE}fecha${NC}             ${AZUL}Muestra la fecha y hora actual${NC}"
echo -e "${MAGENTA}--------------------------------------------------------------------${NC}"
echo -e "${VERDE}buscar${NC}            ${AZUL}Buscar un archivo en un directorio en especifico (recibe dos parametros-La carpeta y el archivo a buscar)${NC}"
echo -e "${MAGENTA}--------------------------------------------------------------------${NC}"
echo -e "${VERDE}creditos${NC}          ${AZUL}Muestra los creditos de los que programaron${NC}"
echo -e "${MAGENTA}--------------------------------------------------------------------${NC}"
echo -e "${VERDE}juego${NC}             ${AZUL}Juego${NC}"
echo -e "${MAGENTA}------------------------------------------------------------------${NC}"
echo -e "${VERDE}mp3${NC}               ${AZUL}Escuchar música${NC}"
echo -e "${MAGENTA}------------------------------------------------------------------${NC}"
echo -e "${VERDE}salir${NC}             ${AZUL}Salir de la terminal${NC}"
printf "\n\n"
