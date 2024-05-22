 #!/bin/bash

nombresOpciones=("🧱" "🧻" "✂")

traducirOpcion() {
    local opcion=$(( $1 - 1 ))
    echo ${nombresOpciones[$opcion]}
}

#Selector_de_modo

selector_de_modo(){
echo "[ 1 -> Mejor de 5 ]"
echo "[ 2 -> Infinito ]"
echo "[ 3 -> Imposible ]"
echo "[ 0 -> Salir ]"

echo "Seleccione el modo de juego:"
read modo
sleep 1
clear
dirigir_modo
}

dirigir_modo(){
    case $modo in
    1) echo "[ Modo 1, mejor de 5 ]"
       echo " " ; mejor_de_5 ;;

    2) echo "[ Modo 2, infinito ]"
       echo " "; infinito ;;

    3) echo "[ Modo 3, imposible ]"
       echo " " ; imposible ;;

    0) echo "[ Salir del juego ]"
       exit ;;

    *) echo "[ Opción no válida ]" 
       selector_de_modo ;;

    esac
}

opcion_juego(){
echo " "
 echo "Elije entre:"
 echo "1 -> 🧱"
 echo "2 -> 🧻"
 echo "3 -> ✂"
 read opcion
 sleep 1
 clear
}

numero_aleatorio(){
    numero=$(( (RANDOM % 3) + 1 ))
}

numero_aleatorio_imposible(){
    numero=$(( (RANDOM % 3) + 1 ))
        declare -a GanaA
    GanaA[1]=3
    GanaA[2]=1
    GanaA[3]=2

    if [[ $opcion == $numero ]]; then
    numero_aleatorio_imposible
    elif [[ ${GanaA[$opcion]} == $numero ]]; then
    numero_aleatorio_imposible
    fi
}

quien_gana() {
    declare -a GanaA
    GanaA[1]=3
    GanaA[2]=1
    GanaA[3]=2

    if [[ $opcion -eq $numero ]]; then
        echo "Empate"
    elif [[ ${GanaA[$opcion]} -eq $numero ]]; then
        echo "Has ganado"
        echo " "
        let "jugada++"
        let "gana_usuario++"
        echo "Jugador HA ELEGIDO " $(traducirOpcion $opcion)
        echo "PC HA ELEGIDO " $(traducirOpcion $numero)
        
    else
        echo "Has perdido"
        echo " "
        let "jugada++"
        let "gana_pc++"
        echo "Jugador HA ELEGIDO " $(traducirOpcion $opcion)
        echo "PC HA ELEGIDO " $(traducirOpcion $numero)
        fi
}


mejor_de_5(){
    jugada=0
    gana_usuario=0
    gana_pc=0
    while [[ $jugada -lt 5 ]]; do
    opcion_juego
    numero_aleatorio
    quien_gana

echo "Te quedan $(( 5 - jugada)) jugadas"
echo "Has ganado $gana_usuario jugadas"

done
ganado_final
}

infinito(){
    jugada=0 #No lo quito porque sino no serviría la función quien_gana
    gana_usuario=0
    gana_pc=0
    while [[ true ]]; do
        opcion_juego
        numero_aleatorio
        quien_gana
        echo "Has ganado $gana_usuario jugadas"
    done
    ganado_final

}


imposible(){
    jugada=0 #No lo quito porque sino no serviría la función quien_gana
    gana_usuario=0
    gana_pc=0
    while [[ true ]]; do
        opcion_juego
        numero_aleatorio_imposible
        quien_gana
        echo "Jugador HA ELEGIDO " $(traducirOpcion $opcion)
        echo "PC HA ELEGIDO " $(traducirOpcion $numero)
        echo "Has ganado $gana_usuario jugadas"
    done
    ganado_final
}
ganado_final(){
    clear
    if [[ gana_usuario -gt gana_pc ]]; then
    echo "Ganas tú 👑"
    else
    echo "Gana el PC 👑"
    fi
    echo "Tu has ganado $gana_usuario jugadas"
    echo "PC ha ganado $gana_pc jugadas"
}
selector_de_modo



