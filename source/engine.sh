#!/bin/bash

suboption_goldberg(){

while true; do
				read -p "$ENG_GOLDOPT " OPTION
				
			if [[ "$OPTION" == [YySs] ]]; then
				break
				
			elif [[ "$OPTION" == [Nn] ]]; then
				break
				clear
			else
				echo "$INVALID_VALUE"
				read -p "$ENTER_RETRY"
				continue
			fi
		done

}

suboption_goldberg2(){

			if [[ "$OPTION" == [YySs] ]]; then
				if [[ "$PLATFORM" == "Windows" ]]; then
					find "$GAMES/$GAME_DIR" -type f \( -name "steam_api64.dll" -o -name "steam_api.dll" \) | while read -r ARC; do
							TARGET_DIR="$(dirname "$ARC")"
							ARC_NAME="$(basename "$ARC")"
						cp "$ARC" "$ARC.bak"
						cp "$GOLD/$ARC_NAME" "$ARC"
							echo "$APPID" > "$TARGET_DIR/steam_appid.txt"
						done
							
				elif [[ "$PLATFORM" == "Linux" ]]; then
							
					find "$GAMES/$GAME_DIR" -type f -name "libsteam_api.so" | while read -r ARC; do
						TARGET_DIR="$(dirname "$ARC")"
							cp "$ARC" "$ARC.bak"
						if file "$ARC.bak" | grep -q "64-bit"; then
							cp "$GOLD/linux/x86_64/libsteam_api.so" "$ARC"
						else
							cp "$GOLD/linux/x86/libsteam_api.so" "$ARC"
						fi
							echo "$APPID" > "$TARGET_DIR/steam_appid.txt"
				done
				fi
							
						if find "$GAMES/$GAME_DIR" -name "*.bak" | grep -q .; then
        							echo "$ENG_GOLDTRUE"
						else
								echo "$ENG_GOLDFALSE"
						fi
			fi

}

submenu_upd(){

suboption_goldberg

steamcmd +@sSteamCmdForcePlatformType "$PLATFORM" +force_install_dir "$GAMES/$GAME_DIR" +login "$USER_STEAM" +app_update "$APPID" validate +quit

suboption_goldberg2
		
}

submenu_eng(){ GAME_NAME=$(curl -s "https://store.steampowered.com/api/appdetails?appids=$APPID&filters=basic" | grep -o '"name":"[^"]*"' | head -n 1 | cut -d '"' -f 4)
		
			if [ -z "$GAME_NAME" ]; then
				echo "$ENG_INVALID"
				read -p "$ENTER_RETRY"
				return
			
			fi
		
		while true; do
				read -p "$ENG_CONFIRM $GAME_NAME? $YES_NOT: " OPTION

			if [[ "$OPTION" == [YySs] ]]; then
				break
			elif [[ "$OPTION" == [Nn] ]]; then
				return
			else
				echo "$INVALID_VALUE"
        			read -p "$ENTER_RETRY"
        			clear
			fi
		done
		while true; do
				read -p "$ENG_PLAT" PLATFORM
			
			if [[ "$PLATFORM" == [Ww] ]]; then
				PLATFORM="Windows"
				break
				
			elif [[ "$PLATFORM" == [Ll] ]]; then
				PLATFORM="Linux"
				break
				
			else
				echo "$INVALID_VALUE"
				read -p "$ENTER_RETRY"
				clear
			fi
		done
				
suboption_goldberg
				
			GAME_DIR="$(echo "$GAME_NAME" | tr -d ':/\\*?"<>|&')"
			steamcmd +@sSteamCmdForcePlatformType "$PLATFORM" +force_install_dir "$GAMES/$GAME_DIR" +login "$USER_STEAM" +app_update "$APPID" validate +quit

				if [ $? -eq 0 ] && [ -d "$GAMES/$GAME_DIR" ]; then	

					suboption_goldberg2

					sed -i "/^${APPID}|/d" "$GAMES/library.conf" 2>/dev/null
					echo "$APPID|$GAME_NAME|$PLATFORM||" >> "$GAMES/library.conf"
					read -p "$ENG_SUCCESS"
					clear
					exec "$FIRST"
				else
					echo ""
					echo "$ENG_ERRO"
					echo "$ENG_ERRO2"
					rm -rf "$GAMES/$GAME_DIR"
					echo ""
					read -p "$ENTER_MENU"
					exec "$FIRST"
				fi
}
