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

while true; do
clear

	echo "        Language selection"
	echo "==================================="
	echo "1- English"
	echo "2- Português"
	echo "3- Español"
	echo "4- System Default"
	echo "==================================="
	read -p "Select a language to start: " OPTION

	case "$OPTION" in
		1)
		echo "Do you really want ENGLISH?"
		read -rsn1 -p "Press ENTER to continue or Q to go back... " KEY

			if [[ "$KEY" == "q" || "$KEY" == "Q" ]]; then
			continue
			fi
	
		LANGUAGE="en"
		
		sed -i "s|^LANGUAGE=.*|LANGUAGE=\"$LANGUAGE\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
		
		break
		
		;;
	
		2)
		echo "Você realmente quer PORTUGUÊS?"
		read -rsn1 -p "Pressione ENTER para continuar ou Q para voltar... " KEY

			if [[ "$KEY" == "q" || "$KEY" == "Q" ]]; then
			continue
			fi
	
		LANGUAGE="pt"
		
		sed -i "s|^LANGUAGE=.*|LANGUAGE=\"$LANGUAGE\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
		
		break
		
		;;
	
		3)
		echo "¿Realmente quieres ESPAÑOL?"
		read -rsn1 -p "Presiona ENTER para continuar o Q para volver... " KEY

			if [[ "$KEY" == "q" || "$KEY" == "Q" ]]; then
    			continue
			fi
		
		LANGUAGE="es"
		
		sed -i "s|^LANGUAGE=.*|LANGUAGE=\"$LANGUAGE\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
		
		break
		
		;;
	
		4)
		echo "$SELECTIONINI"
		LANGUAGE="${LANG%%_*}"

		read -rsn1 -p "$DEFAULT_INI " KEY

			if [[ "$KEY" == "q" || "$KEY" == "Q" ]]; then
			unset LANGUAGE
			continue
			fi
		
		break
		
		;;
		*)
		LANGUAGE="${LANG%%_*}"
		echo "$INVALID_VALUE"
			read -p "$ENTER_RETRY"
			unset LANGUAGE
			continue
		;;
	esac

clear

done

unset OPTION

#NICKNAME

source "$SCRIPT_DIR/source/config.sh"

while true; do
	
	clear
	read -p "$USERNAME_INI " USER_STEAM
	
	read -p "$USERCONFIRMATION_INI $USER_STEAM? $YES_NOT: " OPTION
	
		if [[ "$OPTION" == [YySs] ]]; then
	
			sed -i "s|^USER_STEAM=.*|USER_STEAM=\"$USER_STEAM\"|" "$SCRIPT_DIR/source/TXT/configpath.conf"
			sleep 1
			break
			
		elif [[ "$OPTION" == [Nn] ]]; then
		
			continue
			
		else
			echo "$INVALID_VALUE"
			read -p "$ENTER"
			continue
		fi

done

fi

clear
exec "$FIRST"
