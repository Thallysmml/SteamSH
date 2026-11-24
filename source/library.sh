#!/bin/bash


SOURCE="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SOURCE/config.sh"
source "$SOURCE/engine.sh"


	update_conf(){
		awk -F'|' -v id="$APPID" -v name="$GAME_NAME" -v plat="$PLATFORM" -v exe="$CUSTOM_EXE" -v args="$ARGS" '
			$1 == id { print id "|" name "|" plat "|" exe "|" args; next }
			{ print }
		' "$GAMES/library.conf" > "$GAMES/library.conf.tmp" && mv "$GAMES/library.conf.tmp" "$GAMES/library.conf"
	}

	run_game(){
	
		if [ "$PLATFORM" == "Linux" ]; then
			chmod +x "$TARGET"
			CMD="\"$TARGET\""
		elif [ "$PLATFORM" == "Windows" ]; then
			CMD="WINEPREFIX=\"$UMU/prefixes/$GAME_DIR\" GAMEID=\"umu-$APPID\" UMU_NO_RUNTIME=1 \"$UMU/umu-run\" \"$TARGET\""
		fi

		if [[ "$ARGS" == *"%command%"* ]]; then
			FINAL_CMD="${ARGS/\%command\%/$CMD}"
		else
			FINAL_CMD="$CMD $ARGS"
		fi
			(cd "$(dirname "$TARGET")" && eval "$FINAL_CMD")


	}
	
	suboption_game(){
	
		if [ -d "$GAMES/$GAME_DIR" ]; then
			ARCHIVE="$(uname -m)"
			if [ "$PLATFORM" == "Linux" ]; then
				[[ "$ARCHIVE" == "x86_64" ]] && TIPO="ELF 64-bit" || TIPO="ELF 32-bit"
				TARGET=$(find "$GAMES/$GAME_DIR" -maxdepth 2 -type f -executable ! -name "*.so*" ! -name "*.dll" -printf "%s %p\n" | sort -rn | cut -d' ' -f2- | xargs -d '\n' file 2>/dev/null | grep -E "$TIPO|shell script" | head -n 1 | cut -d':' -f1)
							
				run_game
					
			elif [ "$PLATFORM" == "Windows" ]; then
				TARGET=$(find "$GAMES/$GAME_DIR" -maxdepth 2 -type f -iname "*.exe" \
				! -path "*/_CommonRedist/*" ! -path "*/Redist/*" \
				! -iname "*CrashHandler*" ! -iname "*launcher*" \
				! -iname "*setup*" ! -iname "*unins*" \
				-printf "%s %p\n" | sort -rn | head -n 1 | cut -d' ' -f2-)

    				run_game
			fi
		else
			echo "$LIB_ERROR $GAMES/$GAME_DIR"
			read -p "$ENTER_MENU"
			return
		fi
	
	}

	submenu_lib(){ 
	
	while true; do
	
	clear
	echo "$LIB_DECO"
	echo "$LIB_GAME $GAME_NAME"
	echo "$LIB_DECO2"
	echo "$LIB_PLAT $PLATFORM | AppID: $APPID"
	[[ -n "$CUSTOM_EXE" ]] && echo "$LIB_CUSTOM_EXE $CUSTOM_EXE" | fold -s -w 41
	[[ -n "$ARGS" ]] && echo "$LIB_ARGS $ARGS" | fold -s -w 41
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
				if [ -n "$CUSTOM_EXE" ]; then
					if [ -f "$CUSTOM_EXE" ]; then
						TARGET="$CUSTOM_EXE"
						run_game
					else
						echo "$LIB_ERROR $CUSTOM_EXE"
						read -p "$ENTER_MENU"
						continue
					fi
				else
					suboption_game
				fi
			;;
			2)	
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
								rm -rf "$GAMES/$GAME_DIR"
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
			4)	
				while true; do
				unset OPTION
				read -p "$LIB_CUSTOMEXE " OPTION
					if [[ "$OPTION" == "$CUSTOM_EXEDEL" ]]; then
						unset CUSTOM_EXE
						update_conf
						break
					elif [[ "$OPTION" == "$CUSTOM_EXENEW" ]]; then
						read -p "$LIB_CUSTOMEXE2 $GAME_NAME? $YES_NOT: " OPTION
							if [[ "$OPTION" == [YySs] ]]; then
								unset CUSTOM_EXE
								read -p "$LIB_CUSTOMEXE3 " CUSTOM_EXE
								update_conf
								break
							elif [[ "$OPTION" == [Nn] ]]; then
								break
							else
								echo "$INVALID_VALUE"
								read -p "$ENTER_RETRY"
								continue
							fi
					else
						echo "$INVALID_VALUE"
						read -p "$ENTER_RETRY"
						continue
					fi
				done
			;;
			5)	
				while true; do
					unset OPTION
					read -p "$LIB_ARGSNEW $YES_NOT " OPTION
						if [[ "$OPTION" == [YySs] ]]; then
							echo "$LIB_ARGSHINT"
							read -p "$LIB_ARGSALERT: " ARGS
							update_conf
							break
						elif [[ "$OPTION" == [Nn] ]]; then
							break
						else
							echo "$INVALID_VALUE"
							read -p "$ENTER_RETRY"
							continue
						fi
				done
				continue
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
		CUSTOM_EXE=$(echo "$LINE" | cut -d'|' -f4)
		ARGS=$(echo "$LINE" | cut -d'|' -f5)
		GAME_DIR="$(echo "$GAME_NAME" | tr -d ':/\\*?"<>|&')"
		
		submenu_lib
		continue
	;;
esac

done
