#!/bin/bash



palabras=("bash" "linux" "terminal" "script" "comando" "usuario" "directorio")
palabra_secreta=${palabras[$RANDOM % ${#palabras[@]}]}
longitud=${#palabra_secreta}
intentos=6
letras_correctas=()
letras_usadas=()

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

clear
echo "============================"
echo "      JUEGO DEL AHORCADO"
echo "============================"
sleep 1
#bucle del juego

while (( intentos > 0 )); do
    echo -e "\nIntentos restantes: $intentos"
    echo "Letras usadas: ${letras_usadas[*]}"
    echo -n "Palabra: "
    mostrar_progreso

    read -rp "Adivina una letra (o escribe 'salir' para terminar): " letra

    if [[ "$letra" == "salir" ]]; then
        echo "Has salido del juego. ¡Hasta la próxima!"
        exit 0
    fi

    if [[ ! "$letra" =~ ^[a-zA-Z]$ ]]; then
        echo "Solo una letra."
        continue
    fi

    letra=${letra,,}

    if [[ " ${letras_usadas[*]} " == *" $letra "* ]]; then
        echo " Prueba con otra."
        continue
    fi

    letras_usadas+=("$letra")

    if [[ "$palabra_secreta" == *"$letra"* ]]; then
        letras_correctas+=("$letra")
        echo " La letra '$letra' está en la palabra."
    else
        ((intentos--))
        echo "Incorrecto. La letra '$letra' no está."
    fi

    aciertos=0
    for ((i=0; i<longitud; i++)); do
        if [[ " ${letras_correctas[*]} " == *" ${palabra_secreta:$i:1} "* ]]; then
            ((aciertos++))
        fi
    done

    if (( aciertos == longitud )); then
        echo -e "\n Encontraste la palabra: $palabra_secreta"
        break
    fi
done

if (( intentos == 0 )); then
    echo -e "\nPerdiste. La palabra era: $palabra_secreta"
fi

echo -e "\nGracias por jugar."

