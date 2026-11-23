#!/bin/bash

SOURCE="$(dirname "$(readlink -f "${BASH_SOURCE}")")"
source "$SOURCE/TXT/configpath.conf"

#LINGUAGEM

if [ -z "$LANGUAGE" ]; then
	LANGUAGE="${LANG%%_*}"
fi
	case "$LANGUAGE" in
		pt)
		source "$SOURCE/TXT/pt.lang"
		;;
		es)
		source "$SOURCE/TXT/esp.lang"
		;;
		*)
		source "$SOURCE/TXT/eng.lang"
		;;

	esac

#BIBLIOTECA DE VARIÁVEIS

INI="$(dirname "$SOURCE")/ini.sh"
FIRST="$SOURCE/Steam.sh"
SECOND="$SOURCE/instalador.sh"
FOURTH="$SOURCE/mods.sh"
THIRD="$SOURCE/library.sh"
GOLD="$(dirname "$SOURCE")/wineprefix/goldberg"
UMU="$(dirname "$SOURCE")/wineprefix/umu"
GAMES="$(dirname "$SOURCE")/library"


