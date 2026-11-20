#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SCRIPT_DIR/config.sh"

clear
echo	"$MENU"
read -p "$CHOOSE " OPCAO

case "$OPCAO" in
	0)
		exit 0
		;;
	1)
	if [ -f "$SECOND" ]; then
		clear
		exec "$SECOND"
	else
		echo "$ERROR_MESSAGE1"
		read -p "$ERROR_MESSAGE2"
			clear
			exec "$0"
	fi
		;;
		
	2)
	if [ -f "$THIRD" ]; then
		clear
		exec "$THIRD"
	else
		echo "$ERROR_MESSAGE4"
		read -p "$ERROR_MESSAGE2"
			clear
			exec "$0"
	fi
		;;
	
	3)	
	if [ -f "$FOURTH" ]; then
		clear
		exec "$FOURTH"
	else
		echo "$ERROR_MESSAGE3"
		read -p "$ERROR_MESSAGE2"
			clear
			exec "$0"
	fi
		;;
	
	4)
	clear
	echo "$SECURITYCONFIG"
	read -p "$SECURITYCONFIG2 " SECURITYPATH
		
		if [ "$SECURITYPATH" == "$RECONFIGURE" ]; then
	
	sed -i 's|^LANGUAGE=.*|LANGUAGE=""|' "$SOURCE/TXT/configpath.conf"
	sed -i 's|^USER_STEAM=.*|USER_STEAM=""|' "$SOURCE/TXT/configpath.conf"
		
		echo "$SENDINGUSER"
		sleep 2
		exec "$INI"
		
		else
			echo "$ERROR_INVALID2"
			sleep 2
			clear
			exec "$0"
	
		fi
	;;
	
	*)	echo "$ERROR_INVALID"
		read -p "$ERROR_MESSAGE2"
			clear
			exec "$0"
		;;
esac
