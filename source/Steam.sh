#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SCRIPT_DIR/config.sh"

while true; do
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
		echo "$MENU_ERROR $SOURCE"
		read -p "$ENTER_RETRY"
	fi
		;;
		
	2)
	if [ -f "$THIRD" ]; then
		clear
		exec "$THIRD"
	else
		echo "$MENU_ERROR $SOURCE"
		read -p "$ENTER_RETRY"
	fi
		;;
	
	3)	
	if [ -f "$FOURTH" ]; then
		clear
		exec "$FOURTH"
	else
		echo "$MENU_ERROR $SOURCE"
		read -p "$ENTER_RETRY"
	fi
		;;
	
	4)
	clear
	echo "$MENU_SECURITY"
	read -p "$MENU_SECURITY2 " SECURITYPATH
		
		if [ "$SECURITYPATH" == "$RECONFIGURE" ]; then
	
	sed -i 's|^LANGUAGE=.*|LANGUAGE=""|' "$SOURCE/TXT/configpath.conf"
	sed -i 's|^USER_STEAM=.*|USER_STEAM=""|' "$SOURCE/TXT/configpath.conf"

		exec "$INI"
		
		else
			echo "$MENU_SECURITY3"
			sleep 2
		fi
	;;
	
	*)	echo "$INVALID_VALUE"
		read -p "$ENTER_RETRY"
		;;
esac

done
