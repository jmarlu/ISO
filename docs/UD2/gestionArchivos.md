# Gestión de los Archivos

## Los diferentes tipos de archivos

Distinguimos tres tipos de archivos: **ordinarios, catálogo, especiales.**

### Los archivos ordinarios o regulares

Los archivos ordinarios se llaman también archivos regulares, ordinary files o regular files. Son

archivos totalmente clásicos que contienen datos. Por datos se debe entender cualquier contenido:

- texto;
- imagen;
- audio;
- programa binario compilado
- etc..

Por defecto, nada permite diferenciar unos de otros, salvo la utilización de algunas opciones de
determinados comandos (ls -F por ejemplo) o el comando file.

file nom_arch
nom arch: 32 Bits ELF Executable Binary (stripped)

Linux desconoce la noción de **extensión de archivo** como componente interno de la estructura del
sistema de archivos. Se la considera simplemente como parte del nombre

### Los catálogos

Los archivos catálogo son los **directorios o carpetas**. Los directorios permiten organizar el disco
duro creando una jerarquía. Un directorio puede contener archivos normales, archivos especiales y
otros directorios de manera recursiva.
Un directorio no es **más que un archivo particular que contiene la lista de los propios archivos presentes** en este directorio. Esta noción resultará muy útil cuando se trate el tema de los permisos.

### Los archivos especiales

El tercer tipo de archivos es el especial. Existen varios tipos de archivos **especiales**. Por ejemplo, los
drivers de los periféricos están representados por archivos especiales de la carpeta `/dev`
Son principalmente archivos que sirven de **interfaz para los diversos periféricos**. Se pueden utilizar, según el caso, como archivos normales. Cuando se accede en modo lectura o escritura a estos
archivos se redirigen hacia el periférico (pasando por el driver asociado si existe).

## Nomenclatura de los archivos

No se puede dar cualquier nombre a un archivo; hay que seguir unas simples reglas, válidas para
todos los tipos de archivos.

En los antiguos sistemas Unix, un nombre de archivo no podía superar **los 14 caracteres**. En los
sistemas actuales, Linux incluido, se puede llegar hasta 255 caracteres. La posible extensión está
incluida en la longitud del nombre del archivo.
Un punto extremamente importante: Linux respeta la distinción entre los nombres de archivos en
minúsculas y en mayúsculas. Pepito, PEPITO, PePito y pepito son nombres de archivos diferentes,
con un contenido diferente. Esta distinción es intrínseca al tipo de sistema de archivos. En otros
sistemas de tipo Unix (como Mac OS X) este comportamiento puede ser opcional.
Se acepta la mayoría de los caracteres (las cifras, las letras, las mayúsculas, las minúsculas, ciertos
signos, los caracteres acentuados), incluido el espacio. Sin embargo, se deben evitar algunos
caracteres, ya que tienen un significado particular dentro del shell: & ; ( ) ~ <espacio> \ / | ` ? - (al
principio del nombre).
Los nombres siguientes son válidos:
• Archivo1
• Paga.txt
• 123tratamiento.sh
• Paga_junio_2002.xls
• 8
Los nombres siguientes, aunque válidos, pueden crear problemas:
• Archivo\*
• Pago(diciembre)
• Ben&Nuts
• Paga junio 2002.xls
• -f

## Rutas de acceso a ficheros

Para poder desplazarse dentro de un sistema de ficheros hay que entender una serie de conceptos como directorio actual, padre y raíz:

!!! example inline start "pwd"

      (print working directory) Comando que imprime por pantalla el directorio actual de trabajo.

- **directorio raíz**, es la carpeta desde la cual cuelga todo el sistema de ficheros del GNU/Linux. Marca en inicio de todas las rutas absolutas a seguir.
- **directorio actual**, marca la posición actual en la que el usuario se encuentra. El archivo feo.txt ubicado en el escritorio del usuario feo, tendría como dirección actual /home/feo/Escritorio, que también suele representase como un punto.
- **directorio padre**, identifica la carpeta inmediatamente anterior a la posición actual. En el ejemplo anterior, la carpeta padre del archivo feo.txt sería /home/feo. Todas las direcciones de la estructura de directorios poseen un directorio padre, a excepción del directorio raíz.

Además de manejar estos conceptos con soltura, es necesario entender a qué se hace referencia cuando hablamos de la ruta de una archivo. Se trata de la dirección que, de forma unívoca, ubica al archivo dentro de la estructura de ficheros. En el caso del fichero feo.txt, tendría dos formas de especificar su ruta:

- **ruta absoluta**, que contiene la dirección desde el inicio de la estructura de ficheros hasta el archivo. Este tipo de rutas dependen de sí mismas ya que ofrecen el camino completo para llegar al fichero. En el ejemplo anterior sería `/home/feo/Escritorio/feo.txt`.
- **ruta relativa**, la cual indica la ruta hacia el fichero pero relativa a la posición en la que se encuentra el usuario. Por ejemplo, al iniciar un terminal, el sistema siempre ubica al usuario en su carpeta home. Si iniciamos un terminal con el usuario feo, la ruta hacia el fichero `feo.txt` sería `./Escritorio/feo.txt`. El punto inicial indica la posición actual del usuario y, como se encuentra en su carpeta home, el punto se traduce como `/home/feo`. De este modo, si se suma la dirección actual con la relativa se obtiene la ruta completa al fichero.

Para desplazarse a través del árbol de directorios disponemos del comando `cd (change directory)`, que curiosamente funciona de idéntica forma tanto en el terminal de Microsoft Windows como en el de GNU/Linux. Para acceder a una carpeta tan sólo será necesario indicar su ruta, ya sea absoluta

```bash

cd /home/feo/Escritorio/ISO

```

o relativa al punto en el que el usuario se encuentra

```bash
cd ./Escritorio/ISO
```

!!! example inline start "mkdir"

      `mkdir <nombre>` (make directory) crea un directorio con el nombre especificado. Una opción interesante es `-p` que nos permite realizar una estructura de directorios.

También es posible salir de esa carpeta utilizando la representación del directorio padre (dos puntos seguidos)

```bash
cd ..
```

esto desplaza al usuario a la carpeta padre de la posición actual en la que se encuentra. Si esa ubicación es el escritorio del usuario, es decir `/home/feo/Escritorio`, la ubicación del usuario cambiará a `/home/feo`.
!!! example inline end "cp"

      `cp <origen> <destino>` (copy) Comando para copiar ficheros desde un origen a un destino indicado..

Es de vital importancia que el administrador entienda y domine esta forma de desplazarse entre carpetas y a usar de forma correcta estas tipologías de rutas. Ambas serán utilizadas en función de las necesidades de la tarea a realizar.

!!! example end "cat"

      `cat <archivo>`, muestra el contenido del archivo pasado como parámetro.

!!! example end "touch"

      `touch <fichero>`, crea el fichero pasado como parámetro.
