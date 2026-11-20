dependencies: SteamCMD, curl.

#english

This is a terminal launcher entirely in bash that I made to help me use SteamCMD on a daily basis. If this helps you in any way, download it too.

This is only possible thanks to tools like UMU and Goldberg Emulator (Both licenses are in the root directory).

ATTENTION:

1- This is not piracy, you need to own the game on Steam and have STEAM CMD installed to be able to download games.
2- You might have issues running Windows games due to an AppArmor security restriction (bwrap: setting up uid map: Permission denied) on some operating systems that block the UMU Launcher container.

However, you can work around this and allow AppArmor to no longer have restrictions by running:

```bash
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
```

This won't interfere with running native games, so it's optional, I didn't include it in the code so that it wouldn't be necessary to grant administrator permissions at any time by default.

Note: This command lasts until the next reboot. To make it permanent, create a file at /etc/sysctl.d/99-umu.conf containing kernel.apparmor_restrict_unprivileged_userns=0.

#español

Este es un lanzador en la terminal totalmente en bash que hice para ayudarme a utilizar SteamCMD en el día a día. Si esto te ayuda de alguna forma, descárgalo también.

Esto solo es posible gracias a herramientas como UMU y Goldberg Emulator (Ambas licencias están en la raíz).

ATENCIÓN:

1- Esto no es piratería, necesitas tener el juego en Steam y tener STEAM CMD instalado para poder descargar juegos.
2- Tal vez tengas problemas para ejecutar juegos de Windows debido a una restricción de seguridad de AppArmor (bwrap: setting up uid map: Permission denied) en algunos sistemas operativos que bloquean el contenedor de UMU Launcher.

Sin embargo, puedes sortearlo y permitir que AppArmor ya no tenga restricciones ejecutando:

```bash
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
```

Esto no interferirá en la ejecución de juegos nativos, así que es opcional, no lo incluí en el código para que no sea necesario dar permisos de administrador en ningún momento por defecto.

Nota: Este comando es válido hasta el próximo reinicio. Para hacerlo permanente, crea un archivo en /etc/sysctl.d/99-umu.conf que contenga kernel.apparmor_restrict_unprivileged_userns=0.

#portuguese

Isso é um launcher no terminal totalmente em bash que fiz para me ajudar a utilizar o SteamCMD no dia a dia. Se isso te ajudar de qualquer forma baixe também.

Isso aqui só é possível por conta de ferramentas como o UMU e o Goldberg Emulator (Ambas as licenças estão na raiz).

ATENÇÃO: 

1- Isso aqui não é pirataria, você precisa ter o jogo na Steam e ter o STEAM CMD instalado pra conseguir baixar jogos.
2- Talvez você tenha problemas em executar jogos de Windows por conta de uma restrição de segurança do AppArmor (bwrap: setting up uid map: Permission denied) em alguns sistemas operacionais que bloqueiam o container do UMU Launcher.

Porém você pode contornar e permitir que o AppArmor não tenha mais restrição executando:

```bash
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
```

Isso não vai atrapalhar a rodar jogos nativos, então é opcional, eu não incluí no código para que não seja necessário dar permissão de administrador hora nenhuma por padrão.

Nota: Esse comando vale até a próxima reinicialização. Para tornar permanente, crie um arquivo em /etc/sysctl.d/99-umu.conf contendo kernel.apparmor_restrict_unprivileged_userns=0.
