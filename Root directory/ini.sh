#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SCRIPT_DIR/source/config.sh"

clear

#BIBLIOTECA

if [ ! -d "$GAMES" ]; then

	mkdir -p "$GAMES"

fi

#LANGUAGE

if [ -z "$USER_STEAM" ]; then

	chmod +x "$SCRIPT_DIR"/source/*.sh
	chmod +x "$UMU/umu-run"
	
	echo "        Language selection"
	echo "==================================="
	echo "1- English"
	echo "2- Português"
	echo "3- Español"
	echo "4- System Default"
	echo "==================================="
	read -p "Select a language to start: " OPCAO

	case "$OPCAO" in
		1)
		echo "Do you really want ENGLISH?"
		read -rsn1 -p "Press ENTER to continue or Q to go back... " TECLA

			if [[ "$TECLA" == "q" || "$TECLA" == "Q" ]]; then
    			exec "$0"
			fi
	
		LANGUAGE="en"
		
		sed -i "s|^LANGUAGE=.*|LANGUAGE=\"$LANGUAGE\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
		
		;;
	
		2)
		echo "Você realmente quer PORTUGUÊS?"
		read -rsn1 -p "Aperte ENTER para continuar ou Q para voltar... " TECLA

			if [[ "$TECLA" == "q" || "$TECLA" == "Q" ]]; then
			exec "$0"
			fi
	
		LANGUAGE="pt"
		
		sed -i "s|^LANGUAGE=.*|LANGUAGE=\"$LANGUAGE\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
		
		;;
	
		3)
		echo "¿Realmente quieres ESPAÑOL?"
		read -rsn1 -p "Presiona ENTER para continuar o Q para volver... " TECLA

			if [[ "$TECLA" == "q" || "$TECLA" == "Q" ]]; then
    			exec "$0"
			fi
		
		LANGUAGE="es"
		
		sed -i "s|^LANGUAGE=.*|LANGUAGE=\"$LANGUAGE\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
		
		;;
	
		4)
		echo "$SELECTIONINI"
		LANGUAGE="${LANG%%_*}"
	
		read -rsn1 -p "$SELECTIONINI2 " TECLA
	
			if [[ "$TECLA" == "q" || "$TECLA" == "Q" ]]; then
			unset LANGUAGE
    			exec "$0"
			fi
		
		;;
		*)
		LANGUAGE="${LANG%%_*}"
		echo "$SELECTIONINI3"
			read -p "$SELECTIONINI4"
			unset LANGUAGE
			clear
			exec "$0"
	esac

clear

#NICKNAME

source "$SCRIPT_DIR/source/config.sh"

	read -p "$SELECTIONINI5 " USER_STEAM
	sed -i "s|^USER_STEAM=.*|USER_STEAM=\"$USER_STEAM\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
	sleep 1
fi

clear
exec "$SCRIPT_DIR/source/Steam.sh"
