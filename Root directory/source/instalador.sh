#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/engine.sh"

echo "$INSTALADOR"
echo "$INSTALADOR2"
read -p "$INSTALADOR3 " APPID

case "$APPID" in
	0)
		clear
		exec "$FIRST"
	;;
	""|*[!0-9]*)
		echo "$ERROR_INVALID"
		read -p "$ERROR_MESSAGE2"
		clear
		exec "$SECOND"
	;;
	*)
		submenu_eng
	;;
esac

