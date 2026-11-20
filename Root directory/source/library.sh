#!/bin/bash


SOURCE="$(dirname "$(readlink -f "${BASH_SOURCE}")")"

source "$SOURCE/config.sh"
source "$SOURCE/engine.sh"

	submenu_lib(){ clear
	echo "$SUBMENU1"
	echo "$NAMECHO $NOMEDOJOGO"
	echo "$SUBMENU1"
	echo "$PLATFORMECHO $PLATAFORMA | AppID: $APPID"
	echo "$SUBMENU2"
	echo "$SUBMENULIBOPTIONS"
	echo "$SUBMENU2"
	read -p "$CHOOSE " OPTION
	
		case "$OPTION" in
			0)
				clear
				exec "$THIRD"
			;;
			1)
				if [ -d "$GAMES/$NOMEDOJOGO" ]; then
					ARQ="$(uname -m)"
					if [ "$PLATAFORMA" == "Linux" ]; then
					[[ "$ARQ" == "x86_64" ]] && TIPO="ELF 64-bit" || TIPO="ELF 32-bit"
					ALVO=$(find "$GAMES/$NOMEDOJOGO" -maxdepth 2 -type f -executable ! -name "*.so*" ! -name "*.dll" -printf "%s %p\n" | sort -rn | cut -d' ' -f2- | xargs -d '\n' file 2>/dev/null | grep -E "$TIPO|shell script" | head -n 1 | cut -d':' -f1)
					chmod +x "$ALVO"
					(cd "$GAMES/$NOMEDOJOGO" && "$ALVO")
					submenu_lib
					
					elif [ "$PLATAFORMA" == "Windows" ]; then
						ALVO=$(find "$GAMES/$NOMEDOJOGO" -maxdepth 2 -type f -iname "*.exe" \
						! -path "*/_CommonRedist/*" ! -path "*/Redist/*" \
						! -iname "*CrashHandler*" ! -iname "*launcher*" \
						! -iname "*setup*" ! -iname "*unins*" \
						-printf "%s %p\n" | sort -rn | head -n 1 | cut -d' ' -f2-)

    						(cd "$(dirname "$ALVO")" && WINEPREFIX="$UMU/prefixes/$NOMEDOJOGO" GAMEID="umu-$APPID" UMU_NO_RUNTIME=1 "$UMU/umu-run" "$ALVO")
					submenu_lib
					fi
				else
					echo "$GAMEERROR $GAMES/$NOMEDOJOGO"
					read -p "$ENTERINSTALACAO"
					submenu_lib
				fi
			;;
			2)	
				PASTA_JOGO="$GAMES/$NOMEDOJOGO"
				while true; do
				read -p "$ATTCONFIRMAR " CONFIRM
					if [[ "$CONFIRM" == [YySs] ]]; then
						submenu_att
						break
					
					elif [[ "$CONFIRM" == [Nn] ]]; then
						submenu_lib
						break
					else
						echo "$SELECTIONINI3"
						read -p "$ENTERINSTALACAO"
					fi
				done
			;;
			3)
				while true; do
				read -p "$DELETECONFIRMAR $NOMEDOJOGO$DELETECONFIRMAR2 " DELETEGAME
					if [[ "$DELETEGAME" == [YySs] ]]; then
						read -p "$DELETAR " EXCLUSAO
							if [[ "$EXCLUSAO" == "$DELETE" ]]; then
								rm -rf "$GAMES/$NOMEDOJOGO"
								sed -i "/^${APPID}|/d" "$GAMES/library.conf"
								break
							else
								read -p "$INVALIDDELETE"
							fi
						
					elif [[ "$DELETEGAME" == [Nn] ]];then
						break
					
					else 
						echo "$SELECTIONINI3"
						read -p "$ENTERINSTALACAO"
					fi
				done
				clear
				exec "$0"
			;;
			*)
				echo "$SELECTIONINI3"
				read -p "$SELECTIONINI4"
				clear
				submenu_lib
		esac
	
	}

echo "$BIBLIOTECA"

grep '^[0-9]' "$GAMES/library.conf" | cut -d'|' -f2 | nl -w1 -s '- '

echo "$BIBLIOTECA2"

read -p "$CHOOSE " OPCAO

case "$OPCAO" in
	0)
		clear
		exec "$FIRST"
	;;
	""|*[!0-9]*)		
		echo "$ERROR_INVALID"
		read -p "$ERROR_MESSAGE2"
		clear
		exec "$THIRD"
	;;
	*)
		LINHA=$(grep '^[0-9]' "$GAMES/library.conf" | sed -n "${OPCAO}p")
		
			if [ -z "$LINHA" ]; then
				echo "$BIBLIOTECA3"
				read -p "$ENTERLIBRARY"
				clear
				exec "$0"
			fi
		
		APPID=$(echo "$LINHA" | cut -d'|' -f1)
		NOMEDOJOGO=$(echo "$LINHA" | cut -d'|' -f2)
		PLATAFORMA=$(echo "$LINHA" | cut -d'|' -f3)
		
		submenu_lib
			
	;;
esac

