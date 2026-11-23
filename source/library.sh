#!/bin/bash


SOURCE="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SOURCE/config.sh"
source "$SOURCE/engine.sh"

	submenu_lib(){ 
	
	while true; do
	
	clear
	echo "$LIB_DECO"
	echo "$LIB_GAME $GAME_NAME"
	echo "$LIB_DECO2"
	echo "$LIB_PLAT $PLATFORM | AppID: $APPID"
	echo "$LIB_DECO2"
	echo "$LIB_SUBOPTION"
	echo "$LIB_DECO"
	read -p "$CHOOSE " OPTION
	
		case "$OPTION" in
			0)
				clear
				return
			;;
			1)
				if [ -d "$GAMES/$GAME_NAME" ]; then
					ARCHIVE="$(uname -m)"
					if [ "$PLATFORM" == "Linux" ]; then
					[[ "$ARCHIVE" == "x86_64" ]] && TIPO="ELF 64-bit" || TIPO="ELF 32-bit"
					TARGET=$(find "$GAMES/$GAME_NAME" -maxdepth 2 -type f -executable ! -name "*.so*" ! -name "*.dll" -printf "%s %p\n" | sort -rn | cut -d' ' -f2- | xargs -d '\n' file 2>/dev/null | grep -E "$TIPO|shell script" | head -n 1 | cut -d':' -f1)
					chmod +x "$TARGET"
					(cd "$GAMES/$GAME_NAME" && "$TARGET")
					continue
					
				elif [ "$PLATFORM" == "Windows" ]; then
					TARGET=$(find "$GAMES/$GAME_NAME" -maxdepth 2 -type f -iname "*.exe" \
					! -path "*/_CommonRedist/*" ! -path "*/Redist/*" \
					! -iname "*CrashHandler*" ! -iname "*launcher*" \
					! -iname "*setup*" ! -iname "*unins*" \
					-printf "%s %p\n" | sort -rn | head -n 1 | cut -d' ' -f2-)

    					(cd "$(dirname "$TARGET")" && WINEPREFIX="$UMU/prefixes/$GAME_NAME" GAMEID="umu-$APPID" UMU_NO_RUNTIME=1 "$UMU/umu-run" "$TARGET")
					continue
					fi
				else
					echo "$LIB_ERROR $GAMES/$GAME_NAME"
					read -p "$ENTER_MENU"
					continue
				fi
			;;
			2)	
				GAME_DIR="$(echo "$GAME_NAME" | tr -d ':/\\*?"<>|')"
				while true; do
				read -p "$LIB_UPD " CONFIRM
					if [[ "$CONFIRM" == [YySs] ]]; then
						unset OPTION
						submenu_upd
						break
					
					elif [[ "$CONFIRM" == [Nn] ]]; then
						break
					else
						echo "$INVALID_VALUE"
						read -p "$ENTER_MENU"
					fi
				done
			;;
			3)
				while true; do
				read -p "$LIB_DEL $GAME_NAME? $YES_NOT: " DELETEGAME
					if [[ "$DELETEGAME" == [YySs] ]]; then
						read -p "$LIB_DEL_CONFIRM " DELETEGAME
							if [[ "$DELETEGAME" == "$DELETE" ]]; then
								rm -rf "$GAMES/$GAME_NAME"
								sed -i "/^${APPID}|/d" "$GAMES/library.conf"
								unset DELETEGAME
								break
							else
								read -p "$GLOBAL_SEC"
							fi
						
					elif [[ "$DELETEGAME" == [Nn] ]]; then
						break
					
					else 
						echo "$INVALID_VALUE"
						read -p "$ENTER_RETRY"
					fi
				done
				return
			;;
			*)
				echo "$INVALID_VALUE"
				read -p "$ENTER_RETRY"
				clear
				continue
		esac
		
		done
	
	}

while true; do

clear
echo "$LIB_DECO"
echo "$LIB_NAME"
echo "$LIB_DECO"

grep '^[0-9]' "$GAMES/library.conf" | cut -d'|' -f2 | nl -w1 -s '- '

echo "$LIB_BACKTO"
echo "$LIB_DECO"

read -p "$CHOOSE " OPTION

case "$OPTION" in
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
		LINE=$(grep '^[0-9]' "$GAMES/library.conf" | sed -n "${OPTION}p")
		
			if [ -z "$LINE" ]; then
				echo "$INVALID_VALUE"
				read -p "$ENTER_RETRY"
				continue
			fi
		
		APPID=$(echo "$LINE" | cut -d'|' -f1)
		GAME_NAME=$(echo "$LINE" | cut -d'|' -f2)
		PLATFORM=$(echo "$LINE" | cut -d'|' -f3)
		
		submenu_lib
		continue
	;;
esac

done
