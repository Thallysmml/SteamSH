#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/engine.sh"

while true; do

clear
echo "$INS"
echo "$INS_1"
read -p "$INS_2 " APPID

case "$APPID" in
	0)
		clear
		exec "$FIRST"
	;;
	""|*[!0-9]*)
		echo "$INVALID_VALUE"
		read -p "$ENTER_RETRY"
		continue
	;;
	*)
		submenu_eng
		continue
	;;
esac

done
