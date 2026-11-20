#!/bin/bash

submenu_att(){
			while true; do
				read -p "$GOLDOPTION " GOLD_SELECTION
				
			if [[ "$GOLD_SELECTION" == [YySs] ]]; then
				break
				
			elif [[ "$GOLD_SELECTION" != [Nn] ]]; then
				echo "$SELECTIONINI3"
				read -p "$ENTERINSTALACAO"
				clear
			else
				break
			fi
		done

steamcmd +@sSteamCmdForcePlatformType "$PLATAFORMA" +force_install_dir "$PASTA_JOGO" +login "$USER_STEAM" +app_update "$APPID" validate +quit

			if [[ "$GOLD_SELECTION" == [YySs] ]]; then
				if [[ "$PLATAFORMA" == "Windows" ]]; then
					find "$PASTA_JOGO" -type f \( -name "steam_api64.dll" -o -name "steam_api.dll" \) | while read -r ARQUIVO; do
							PASTA_DESTINO="$(dirname "$ARQUIVO")"
							NOME_ARQUIVO="$(basename "$ARQUIVO")"
						cp "$ARQUIVO" "$ARQUIVO.bak"
						cp "$GOLD/$NOME_ARQUIVO" "$ARQUIVO"
							echo "$APPID" > "$PASTA_DESTINO/steam_appid.txt"
						done
							
				elif [[ "$PLATAFORMA" == "Linux" ]]; then
							
					find "$PASTA_JOGO" -type f -name "libsteam_api.so" | while read -r ARQUIVO; do
						PASTA_DESTINO="$(dirname "$ARQUIVO")"
							cp "$ARQUIVO" "$ARQUIVO.bak"
						if file "$ARQUIVO.bak" | grep -q "64-bit"; then
							cp "$GOLD/linux/x86_64/libsteam_api.so" "$ARQUIVO"
						else
							cp "$GOLD/linux/x86/libsteam_api.so" "$ARQUIVO"
						fi
							echo "$APPID" > "$PASTA_DESTINO/steam_appid.txt"
				done
				fi
							
						if find "$PASTA_JOGO" -name "*.bak" | grep -q .; then
        							echo "$GOLDSUCCESS"
						else
								echo "$GOLDFAIL"
						fi
			fi
			
		read -p "$INSTALADO"
		submenu_lib
		
}

submenu_eng(){ NOME_JOGO=$(curl -s "https://store.steampowered.com/api/appdetails?appids=$APPID&filters=basic" | grep -o '"name":"[^"]*"' | head -n 1 | cut -d '"' -f 4)
		
			if [ -z "$NOME_JOGO" ]; then
			echo "$INVALID_INSTALL"
			read -p "$ERROR_MESSAGE2"
			clear
			exec "$SECOND"
			fi
		
		while true; do
				read -p "$CONFIRM_GAME1 $NOME_JOGO $CONFIRM_GAME2" OPCAO

			if [[ "$OPCAO" == [YySs] ]]; then
				break
			elif [[ "$OPCAO" == [Nn] ]]; then
				clear
				exec "$SECOND"
			else
				echo "$SELECTIONINI3"
        			read -p "$ENTERINSTALACAO"
        			clear
			fi
		done
		while true; do
				read -p "$CHOOSE_PLATFORM" PLAT
			
			if [[ "$PLAT" == [Ww] ]]; then
				PLATFORM="Windows"
				break
				
			elif [[ "$PLAT" == [Ll] ]]; then
				PLATFORM="Linux"
				break
				
			else
				echo "$SELECTIONINI3"
				read -p "$ENTERINSTALACAO"
				clear
			fi
		done
				
			while true; do
				read -p "$GOLDOPTION " GOLD_SELECTION
				
			if [[ "$GOLD_SELECTION" == [YySs] ]]; then
				break
				
			elif [[ "$GOLD_SELECTION" != [Nn] ]]; then
				echo "$SELECTIONINI3"
				read -p "$ENTERINSTALACAO"
				clear
			else
				break
			fi
		done
				
			PASTA_JOGO="$(echo "$NOME_JOGO" | tr -d ':/\\*?"<>|')"
			steamcmd +@sSteamCmdForcePlatformType "$PLATFORM" +force_install_dir "$GAMES/$PASTA_JOGO" +login "$USER_STEAM" +app_update "$APPID" validate +quit
			
				if [ $? -eq 0 ] && [ -d "$GAMES/$PASTA_JOGO" ]; then
					echo ""
						
						if [[ "$GOLD_SELECTION" == [YySs] ]]; then
							if [[ "$PLAT" == [Ww] ]]; then
								find "$GAMES/$PASTA_JOGO" -type f \( -name "steam_api64.dll" -o -name "steam_api.dll" \) | while read -r ARQUIVO; do
									PASTA_DESTINO="$(dirname "$ARQUIVO")"
									NOME_ARQUIVO="$(basename "$ARQUIVO")"
								cp "$ARQUIVO" "$ARQUIVO.bak"
								cp "$GOLD/$NOME_ARQUIVO" "$ARQUIVO"
								echo "$APPID" > "$PASTA_DESTINO/steam_appid.txt"
							done
							
							elif [[ "$PLAT" == [Ll] ]]; then
							
							find "$GAMES/$PASTA_JOGO" -type f -name "libsteam_api.so" | while read -r ARQUIVO; do
								PASTA_DESTINO="$(dirname "$ARQUIVO")"
										cp "$ARQUIVO" "$ARQUIVO.bak"
									if file "$ARQUIVO.bak" | grep -q "64-bit"; then
										cp "$GOLD/linux/x86_64/libsteam_api.so" "$ARQUIVO"
									else
										cp "$GOLD/linux/x86/libsteam_api.so" "$ARQUIVO"
									fi
										echo "$APPID" > "$PASTA_DESTINO/steam_appid.txt"
							done
							fi
							
							if find "$GAMES/$PASTA_JOGO" -name "*.bak" | grep -q .; then
        							echo "$GOLDSUCCESS"
							else
								echo "$GOLDFAIL"
							fi
						fi
					
					read -p "$INSTALADO"
					sed -i "/^${APPID}|/d" "$GAMES/library.conf" 2>/dev/null
					echo "$APPID|$NOME_JOGO|$PLATFORM" >> "$GAMES/library.conf"
					clear
					exec "$FIRST"
				else
					echo ""
					echo "$ERROINSTALACAO"
					echo "$ERROINSTALACAO2"
					rm -rf "$GAMES/$PASTA_JOGO"
					echo ""
					read -p "$ENTERINSTALACAO"
					clear
					exec "$FIRST"
				fi
}
