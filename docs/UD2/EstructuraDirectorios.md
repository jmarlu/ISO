# Estructura de directorios de sistemas operativos libres y propietarios

En los sistemas operativos basados en Microsoft Windows, asigna una letra a cada una de las particiones de un disco duro. Automáticamente esa letra indica el directorio raíz de esa partición. De ese modo, si disponemos de un fichero alojado en la carpeta `C:\Usuarios\Feo\Escritorio`, gracias a la primera letra sabemos que está contenido en una partición mientras que el fichero `D:\SteamLibrary\steamapps\common\DARK SOULS III` lo está en otra partición. En este sistema las letras A: y B: se reservan históricamente para las unidades de disquetes, ya en desuso. Es posible la asignación de cualquier letra del alfabeto inglés a cualquier partición.

Además de este sistema de asignación de letras, también existe otro sistema que es el de montar particiones en carpetas. Montar una partición implica dotarle de un punto de entrada a su espacio de almacenamiento, de esta forma es posible que la carpeta `D:\Documentos` no se sitúe en el mismo dispositivo físico que la anterior carpeta. Este sistema, aunque parezca raro, presenta numerosas ventajas y es el más utilizado.

Por lo que respecta a los sistemas basados en Unix, la estructura de los directorios así como su contenido y funciones, viene definida en el denominado **Filesystem Hierarchy Standard o FHS** por sus siglas en inglés. En otras palabras es el estándar de jerarquía para los sistemas de archivos en sistemas GNU/Linux y otros derivados de Unix. El FHS nació en 1994 y es actualmente mantenida por la Linux Foundation. Aun siendo un estándar, existen distribuciones GNU/Linux que se saltan estas normas, aunque en la mayoría de los casos son aceptadas.

!!! example inline start "rm"

      `rm <fichero>` (remove) Elimina el/los ficheros pasado/s como parámetro.

Antes de empezar a listar los diferentes directorios, es importante recordar que aunque todos ellos parten de una única raíz común, no significa que no puedan estar en particiones separadas. De hecho, en muchas distribuciones GNU/Linux es una práctica muy común el hecho de ubicar ciertos directorios en particiones separadas.

Toda la estructura de directorios en los sistemas basados en Unix parte de un directorio raíz también llamado directorio **root** y que se simboliza por una **barra inclinada o /**. Desde este directorio inicial es donde nacen todo el resto de directorios, independientemente que estén almacenados físicamente en discos o particiones separadas.

!!! example inline end "rmdir"

      `rmdir <directorio>` (remove directory), elimina el directorio pasado como parámetro.

Cualquier dirección de archivo o carpeta en Linux empieza por el directorio raíz o /, seguido de todos los directorios y subdirectorios que que lo contienen, separados cada uno de ellos también por /.
Todas las distribuciones GNU/Linux deben tener una estructura de directorios como indica la FHS, aunque existen algunas que han introducido algunos cambios menores que no afectar a su estructura.

| Directorio | Contenido                                                         |
| ---------- | ----------------------------------------------------------------- |
| `bin`      | Archivos binarios de usuario                                      |
| `boot`     | Archivos ejecutables necesarios para el arranque del sistema      |
| `dev`      | Archivos de información de dispositivos                           |
| `etc`      | Archivos de configuración del sistema y de aplicaciones           |
| `home`     | Directorio personal con los espacios personales de los usuarios   |
| `lib`      | Bibliotecas necesarias para la ejecución de los archivos binarios |
| `media`    | Directorio de montaje de volúmenes extraíbles                     |
| `mnt`      | Carpeta de montaje de volúmenes fijos                             |
| `opt`      | Archivos de aplicaciones externas que no se integran en /usr      |
| `root`     | Carpeta personal del superusuario                                 |
| `sbin`     | Archivos binarios del sistema                                     |
| `srv`      | Archivos relativos a servicios                                    |
| `tmp`      | Carpeta de archivos temporales                                    |
| `usr`      | Archivos de programas                                             |
