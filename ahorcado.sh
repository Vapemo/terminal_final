#!/bin/bash



palabras=("bash" "terminal" "script" "linux" "comando" "reproductor" "sistema")
palabra_secreta=${palabras[$RANDOM % ${#palabras[@]}]}
longitud=${#palabra_secreta}
intentos=6
letras_correctas=()
letras_usadas=()

# muestra  el progreso del jugador
mostrar_progreso() {
    for ((i=0; i<longitud; i++)); do
        letra="${palabra_secreta:$i:1}"
        if [[ " ${letras_correctas[*]} " == *" $letra "* ]]; then
            echo -n "$letra "
        else
            echo -n "_ "
        fi
    done
    echo ""
}

# inicio
clear
echo "============================"
echo "      JUEGO DEL AHORCADO"
echo "============================"
sleep 1

# bucle  principal del juego
while (( intentos > 0 )); do
    echo -e "\nIntentos restantes: $intentos"
    echo "Letras usadas: ${letras_usadas[*]}"
    echo -n "Palabra: "
    mostrar_progreso

    read -rp "Adivina una letra: " letra

    # validaciones
    if [[ ! "$letra" =~ ^[a-zA-Z]$ ]]; then
        echo "Por favor, ingresa solo una letra."
        continue
    fi

    letra=${letra,,}  # se convierte a  minúscula

    if [[ " ${letras_usadas[*]} " == *" $letra "* ]]; then
        echo "Ya usaste esa letra. Intenta con otra."
        continue
    fi

    letras_usadas+=("$letra")

    if [[ "$palabra_secreta" == *"$letra"* ]]; then
        letras_correctas+=("$letra")
        echo "¡Bien! La letra '$letra' está en la palabra."
    else
        ((intentos--))
        echo "Fallaste. La letra '$letra' no está."
    fi

    # verificación si se gana
    aciertos=0
    for ((i=0; i<longitud; i++)); do
        if [[ " ${letras_correctas[*]} " == *" ${palabra_secreta:$i:1} "* ]]; then
            ((aciertos++))
        fi
    done

    if (( aciertos == longitud )); then
        echo -e "\n¡Felicidades! Palabra correcta: $palabra_secreta 
        break
    fi
done

if (( intentos == 0 )); then
    echo -e "\nPalabra incorrecta La palabra era: $palabra_secreta"
fi

echo -e "\nGracias por jugar."
