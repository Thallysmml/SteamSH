# English

This is a terminal launcher entirely in bash that I made to help me use SteamCMD on a daily basis. If this helps you in any way, download it too.

With this update, I already see my Bash launcher as 100% usable on a daily basis. I added the option to set a manual path for your game executables, as well as launch options. To use them, you do it the exact same way you would on Steam, placing Environment Variables and Wrappers before %command%. It's nothing huge, but the main advantage is giving you the ability to keep your games neatly organized in a launcher that uses nowhere near 1MB of RAM and has no DRM. For my use case, it makes total sense—I hope it does for you too. =)

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

--------------------------------------------------------------------------------------------------------------------------------------

# Español

Este es un lanzador en la terminal totalmente en bash que hice para ayudarme a utilizar SteamCMD en el día a día. Si esto te ayuda de alguna forma, descárgalo también.

Con esta actualización ya veo mi lanzador en Bash 100% utilizable en el día a día. Añadí la opción de indicar una ruta manual para los ejecutables de tus juegos, y también comandos de lanzamiento. Para usarlos, lo haces exactamente igual que en Steam, poniendo las Variables de Entorno y Wrappers antes de %command%. No es la gran cosa, pero la principal ventaja es darte la posibilidad de tener tus juegos bien organizados en un lanzador que pasa lejos de usar 1 MB de RAM y sin DRM. Para mi uso tiene todo el sentido del mundo, espero que para ti también. =)

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

--------------------------------------------------------------------------------------------------------------------------------------

# Portuguese

Isso é um launcher no terminal totalmente em bash que fiz para me ajudar a utilizar o SteamCMD no dia a dia. Se isso te ajudar de qualquer forma baixe também.

Com essa atualização eu já enxergo o meu launcher em bash 100% utilizável no dia a dia, eu adicionei a opção de indicar um caminho manual para seus executáveis de jogos, e também comandos de inicialização. Para usar você faz exatamente como faria na Steam com Environment Variables e Wrappers antes de %command%. Não é grande coisa, mas a principal vantagem é dar a possibilidade de ter seus jogos organizadinhos em um launcher que passa longe de usar 1mb de ram e sem DRM, pra meu uso faz total sentido, espero que faça pra você também. =)

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

--------------------------------------------------------------------------------------------------------------------------------------

dependencies: `SteamCMD`, `curl`.
