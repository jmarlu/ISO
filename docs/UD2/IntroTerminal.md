# Introducción al terminal de comandos

Hasta hace bien poco, toda la gestión del sistema operativo GNU/Linux se basaba en la ejecución de órdenes en entrono de comandos a través de un terminal. Actualmente se dispone de interfaces gráficas que facilitan la gestión, pero no poseen la potencia de los terminales. En un terminal es posible crear cualquier comando que el usuario necesite, incluso para las tareas más específicas. Es buena práctica que el administrador del sistema tenga conocimientos en el manejo del terminal así como en la programación de scripts.

En general, el formato de las órdenes de GNU/Linux es el siguiente:

- **comando**, que indica la acción que se va a ejecutar
- **modificadores**, que cambian el comportamiento estándar del comando para adaptarlo a las necesidades
- **argumentos**, elementos necesarios para realizar la acción del comando

!!! example annotate "mayúsculas"

    Un dato a tener en cuenta cuando se trabaja con un terminal, es que GNU/Linux distingue entre mayúsculas y minúsculas, es decir, es *case sesitive*.

Lo primero que se introduce es la orden seguida de los modificadores o parámetros y, tras ellos, los argumentos que requiera el comando. Existen muchos comandos que no requieren argumento alguno para realizar su función:

`bash comando modificadores argumentos`

La forma de identificar que el sistema está preparado para recibir ordenes en el terminal se realiza a través de una línea de texto llamada _prompt_:

!!! example inline start "Terminal"

      Para abrir un terminal bastará con pulsar las teclas  ++ctrl+alt+t++ , o bien escribir la palabra “terminal” en el lanzador de Ubuntu. Para poder escribir la virgulilla pulsa ++alt-graph+4++ y después la tecla ++space++.

El _prompt_ esta compuesto de varias partes. La primera es el nombre del usuario con el que se está trabajando, en este caso, el usuario es feo. La segunda parte, que esta después de la arroba (@), es el nombre de la máquina en la que se ejecuta el terminal. En el ejemplo anterior la máquina se llama ubuntu. La tercera parte, que está después de los dos puntos : , es el directorio actual de trabajo.

Cuando aparece la **virgulilla**, o tilde ++ctrl+alt+del++ de la letra eñe `~`, nos está indicando que el directorio actual de trabajo es el directorio personal del usuario, también conocido como directorio `home`.

Y por último, al final del _prompt_ puede aparecer o bien el símbolo del dólar `$`, lo que indica que se trabaja con un usuario con privilegios limitados, o la almohadilla `#`, con lo que el sistema indica que el usuario que ejecuta la terminal es el administrador, que en GNU/Linux se llama root.

Para dar una orden al sistema, se escribe el comando que se va a ejecutar y pulsar la tecla <span class="menu">enter</span>

```bash
 ls
```

Por ejemplo, en la línea anterior se está ejecutando el comando `ls`, que permite ver un listado de subdirectorios y archivos del directorio actual de trabajo, que es el directorio personal del usuario porque aparece la **virgulilla**.

A la mayor parte de los comandos se les pueden añadir opciones (también se pueden llamar parámetros, modificadores o argumentos), que modifican su comportamiento. De este modo, el comando

```bash
 ls -l -a
```

está utilizando opciones para que el comando ls muestre también los archivos ocultos e información adicional de cada subdirectorio o archivo que hay en el directorio actual. Para que el sistema diferencie el comando de las opciones o una opción de otra opción, los comandos y sus opciones se escriben utilizando el espacio para separarlos.

Por lo general las opciones suelen ser un guion - y una letra, pero también es posible encontrar opciones que son palabras completas precedidas por dos guiones `--`. Es posible unir las opciones representadas por una letra para escribir un poco menos. La secuencia de opciones -l -a hace exactamente lo mismo que `-la`, de hecho `-la, -al, -l -a y -a -l` devuelven el mismo resultado.

!!! example inline end "Clear"

      Este comando se utiliza para limpia el texto de la pantalla del terminal. Dejará únicamente el prompt..

```bash
 ls -la
 ls -al
 ls -l -a
 ls -a -l
```

Junto con los comandos, también es posible usar los metacarácteres para seleccionar a qué ficheros se quiere afectar con el comando. Para eso utilizamos los siguientes caracteres:

- **?**, que representa cualquier carácter una vez
- **\***, que representa cualquier carácter cualquier número de veces
- **[ ]**, que representa un carácter de los incluidos entre los corchetes
- **!**, que representa la ausencia de ese carácter en el patrón de filtrado

Así, si es necesario listar los ficheros que comiencen con la letra “f”, se usará el siguiente comando

```bash
 ls f*
```

o, por ejemplo, los ficheros o directorios que comiencen por la letras D o P

```bash
ls [DP]*
```

Para poder utilizar los caracteres ? y ! se deben asignar a un patrón de búsqueda, que trataremos en lo sucesivo.

## Obtención de ayuda en un terminal

!!! example inline end "Exit"

      Comando que cierra y sale del terminal actual. Si hay procesos iniciados desde el terminal, también se cerrarán.

Queda lejos de la intención de esta unidad de trabajo la explicación de todos los comandos del sistema GNU/Linux así como de sus modificadores u opciones. Existen varios métodos de obtener ayuda sobre un comando para no tener que recordar cientos de opciones de cada comando:

- usar el **modificador** `--help`, ofrecerá una guía rápida de uso y de los modificadores más utilizados del comando.
- usar el comando `man`, el cual imprimirá una guía de uso del comando. Su uso es sencillo, basta con anteponer man al comando sobre el que se requiera información.
- Usar `info` es similar a `man`, pero las páginas están estructuradas, ofrecen vínculos, un índice, una jerarquía o menús. Las páginas info pueden llamarse entre ellas y ofrecen frecuentemente una navegación amigable.

### El manual en línea.Man

Vamos a detenernos en este comando porque es uno de los más importante y tenemos que entenderlo para poder utilizar los comandos. Esta manual es estándar en todos los Unix, incluso Linux, y no importa cuál sea el **shell**, ya que se trata de un comando externo.
Al manual se accede con el comando y el nombre del comando que queramos ejemplo

```bash

 man date

```

Y nos da como resultado:

```bash

DATE(1)                                                                                         User Commands                                                                                        DATE(1)

NAME
       date - print or set the system date and time

SYNOPSIS
       date [OPTION]... [+FORMAT]
       date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]

DESCRIPTION
       Display the current time in the given FORMAT, or set the system date.

       Mandatory arguments to long options are mandatory for short options too.

       -d, --date=STRING
              display time described by STRING, not 'now'

       --debug
              annotate the parsed date, and warn about questionable usage to stderr

       -f, --file=DATEFILE
              like --date; once for each line of DATEFILE

       -I[FMT], --iso-8601[=FMT]
              output  date/time  in  ISO  8601  format.   FMT='date'  for  date  only  (the  default),  'hours',  'minutes',  'seconds',  or  'ns'  for  date and time to the indicated precision.  Example:
              2006-08-14T02:34:56-06:00
```

Una página de manual se compone de varias secciones, entre las cuales están las siguientes, aunque no son todas obligatorias.

- **Nombre**: nombre y papel del comando.
- **Sinopsis**: sintaxis general, parámetros y argumentos aceptados.
- **Descripción**: instrucciones detalladas del funcionamiento del comando y de los argumentos principales.
- **Opciones**: descripción detallada de cada parámetro posible, en general en forma de lista.
- **Ejemplos**: el manual puede proporcionar ejemplos concretos de uso del comando.
- **Entorno**: el comando puede funcionar de manera diferente dependiendo de los valores que adopten algunas de las variables del shell.
- **Conformidad**: el comando se ajusta a unas recomendaciones o normas (por ejemplo, POSIX).
- **Errores** (bugs): el comando puede a veces funcionar mal en casos puntuales que se pueden enumerar en este sitio.
- **Diagnóstico/retorno**: el comando, según su resultado, puede devolver códigos de errores significativos cuyo valor permite determinar el tipo de problema (archivo con argumento ausente, etc.). - **Ver** también: lista de los comandos relacionados con el programa que pueden interesar al usuario.

#### Navegación

Se navega muy fácilmente por la ayuda:

- La ++space++ desplaza una página completa.
  - La ++Enter++ desplaza línea por línea.
  - Las ++arrow-up++ y ++arrow-down++ desplazan una línea arriba o abajo.
  - Las teclas ++pg-dn++ y ++pg-up++ desplazan media página arriba o abajo.
  - Las teclas ++home++ y ++end++ hacen exactamente lo que se espera de ellas.
  - La tecla ++slash++ permite una búsqueda. `/ls` busca **ls**. En este caso, la tecla ++n++ busca la coincidencia siguiente, mientras que ++N++ busca la anterior.
  - La tecla ++q++ sale de la ayuda y vuelve al shell.

#### Buscar por correspondencia

Si no sabemos que comando que debe utilizar o no recuerda su nombre, o si quiere conocer todos los comandos relacionados con una palabra, entonces utilice el parámetro `-k` de man:

```bash

man -k password

```

Y nos da como resultado:

```bash

apg (1)              - generates several random passwords
chage (1)            - change user password expiry information
chgpasswd (8)        - update group passwords in batch mode
chpasswd (8)         - update passwords in batch mode
cpgr (8)             - copy with locking the given file to the password or group file
cppw (8)             - copy with locking the given file to the password or group file
cracklib-check (8)   - Check passwords using libcrack2
create-cracklib-dict (8) - Check passwords using libcrack2
endpwent (3)         - get password file entry
endspent (3)         - get shadow password file entry
expiry (1)           - check and enforce password expiration policy
fgetpwent (3)        - get password file entry
fgetspent (3)        - get shadow password file entry
fgetspent_r (3)      - get shadow password file entry
getpass (3)          - get a password
getpw (3)            - reconstruct password line entry

```

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

Es de vital importancia que el administrador entienda y domine esta forma de desplazarse entre carpetas y a usar de forma correcta estas tipologías de rutas. Ambas serán utilizadas en función de las necesidades de la tarea a realizar.

!!! example end "cat"

      `cat <archivo>`, muestra el contenido del archivo pasado como parámetro.

!!! example end "touch"

      `touch <fichero>`, crea el fichero pasado como parámetro.

## Redirecciones

Las **redirecciones** son una de las más importantes posibilidades proporcionadas por el shell. Por
redirección se entiende la posibilidad de redireccionar la visualización de la pantalla hacia un
archivo, una impresora o cualquier otro periférico, los mensajes de errores hacia otro archivo, de
sustituir la introducción vía teclado por el contenido de un archivo.

!!! note

      Cualquier flujo de datos en entrada o salida de comando pasa por un **canal**. Como sucede con el
      agua, es posible desviar el curso de los datos hacia otro destino o desde otra fuente.

Linux utiliza **canales de entradas/salidas** para leer y escribir sus datos. Por defecto, el canal de
entrada es el teclado, y el canal de salida, la pantalla. Los errores, direccionados por defecto a la
pantalla, son tratados como un canal especial.

Es posible redireccionar estos canales hacia archivos o flujo de texto de manera transparente para
los comandos Linux.

## De salida

Se puede utilizar el carácter `>` para redireccionar la salida estándar (la que va normalmente en la
pantalla). Luego se indica el nombre del archivo donde se colocarán los resultados de salida.

```bash title=""

$ ls -l > resultado.txt

```

**El shell empieza primero por crear el archivo y luego ejecuta el comando.**

!!!warning

      Es un aspecto importante de las redirecciones: se interpretan las redirecciones de derecha a izquierda, y se instalan las redirecciones ANTES de la ejecución de los comandos. Hay que crear el archivo antes de poder escribir en él. De ahí que, incluso si el comando es falso, se crea o se "chafa" el archivo...

Para añadir datos a continuación del archivo, o sea, sin sobreescribirlos, se utiliza la doble redirección `>>`. Se añade el resultado del comando al final del archivo.

```bash title="Ejemplo añadir"
ls -l > resultado.txt
 date >> resultado.txt
```

## En entrada

Los comandos que esperan datos o parámetros desde el teclado pueden también recibirlos desde un
archivo usando el carácter <. Un ejemplo con el comando `wc (word count)`, que permite contar el
número de líneas, de palabras y de caracteres de un archivo:

```bash title=""
 wc < resultado.txt
4 29 203
```

## Los canales estándares

Se puede considerar un canal como un archivo que posee su propio descriptor por defecto, y en el
cual se puede leer o escribir.

- El canal de entrada estándar se llama **stdin** y lleva el descriptor 0.
- El canal de salida estándar se llama **stdout** y lleva el descriptor 1.
- El canal de error estándar se llama **stderr** y lleva el descriptor 2. Se puede redireccionar el
  canal de error hacia otro archivo.

```bash title=""
rmdir directorio2
rmdir: `directorio2’: No such file or directory
 rmdir directorio2 2>error.log
 cat error.log
rmdir: `directorio2’: No such file or directory
```

Puede redireccionar los dos canales de salida a un único archivo poniéndolos en relación. Para ello,
se utiliza el `>&`. También es importante saber en qué sentido el shell interpreta las redirecciones. El
shell busca primero los caracteres `<, >, >>` al final de la línea, ya que las redirecciones suelen estar
al final de comando. Por lo tanto, si quiere agrupar los dos canales de salida y de error en un mismo
archivo, hay que proceder como a continuación.

```bash title="En mismo archivo los errores y la salida estándar"
ls -l > resultado.txt 2>&1
```

Se redirecciona la salida 2 hacia la salida 1; por lo tanto, los mensajes de error pasarán por la salida
estándar. Luego se redirecciona el resultado de la salida estándar del comando ls hacia el archivo
resultado.txt. Este archivo contendrá, por lo tanto, a la vez la salida estándar y la salida de error.

Puede utilizar los dos tipos de redirección a la vez:

```bash title=""
wc < resultado.txt > cuenta.txt
cat cuenta.txt

```

## Pipelines/tuberías

Las redirecciones de entrada/salida como las que acaba de ver permiten redireccionar los resultados
hacia un archivo. Luego se puede reinyectar en un filtro para extraerle otros resultados. Esto obliga
a teclear dos líneas: una para la redirección hacia un archivo, otra para redireccionar este archivo
hacia el filtro. Las tuberías o pipes permiten redirigir el canal de salida de un comando hacia el
canal de entrada de otro.
El carácter que lo permite `|` está accesible con la combinación [AltGr] 1 de los teclados españoles.

```bash title=""
ls -l > resultado.txt
 wc < resultado.txt
se convierte en
 ls -l | wc
Es posible colocar varios | en una misma línea.
 ls -l | wc | wc
1
 3
 24
```

El primer comando no tiene por qué ser un filtro. No es el caso más habitual. Lo importante es que
se debe facilitar un resultado. Ídem para el último comando, que puede ser por ejemplo un comando
de edición o impresión. Finalmente, el último comando puede ser objeto de una redirección de
salida.

```bash title=""
ls -l | wc > resultado.txt
```

## Filtros

Un filtro (o un comando filtro) es un programa que sabe escribir y leer datos por los canales
estándares de entrada y salida. Modifica o trata si es preciso el contenido. `wc` es un filtro. Las
herramientas no siempre se comportan como filtros. Permiten un determinado número de acciones
en archivos y su contenido, como, por ejemplo, dar formato o imprimir.

### Búsqueda de líneas

Se trata de extraer líneas de un archivo según varios criterios. Para ello, dispone de tres comandos:
`grep, egrep`, que leen los datos o bien desde un archivo de entrada, o bien desde el canal de
entrada estándar.

#### grep

```bash title=" sintaxis de grep"
grep [Opciones] modelo [Archivo1...]
```

El **modelo se compone de criterios de búsqueda**. No hay que olvidar que se debe interpretar estos criterios con el comando grep, y no con el shell. Por lo tanto, hace falta cerrar todos los caracteres.

```bash title="Ejemplo, búsqueda de líneas que comiencen por b o B"
cat fic4
Cerdo
Ternera
Buey
rata
Rata
buey

 grep "ˆ[bB]" fic4
Buey
buey
```

El comando grep también puede tomar algunas opciones interesantes.

- `-v` efectúa la búsqueda inversa: se visualizan todas las líneas que no corresponden a los
  criterios.
- `-c` sólo devuelve el número de líneas encontradas, sin mostrarlas.
- `-i`no diferencia las mayúsculas de las minúsculas.
- `-n` indica el número de línea para cada línea encontrada.
- `-l` en el caso de archivos múltiples, indica en qué archivo se ha encontrado la línea.

```bash title="Ejemplo, con la opción -i "
$ grep -i "ˆb" fic4
Buey
buey
```

#### egrep

El comando egrep extiende los criterios de búsqueda y puede aceptar un archivo de criterios en
entrada. Equivale a un `grep -E`. Emplea como criterios expresiones regulares.

```bash title=" sintaxis de grep"
egrep -f archivo_criterio archivo_búsqueda
```

| Carácter especial | Significado                                                             |
| ----------------- | ----------------------------------------------------------------------- |
| `\|`              | O lógico, la expresión colocada antes o después debe desaparecer.       |
| `(...)`           | Agrupación de caracteres.                                               |
| `[...]`           | Un carácter tiene esta posición entre los indicados.                    |
| `. (punto)`       | Cualquier carácter.                                                     |
| `+`               | Repetición, el carácter colocado antes debe aparecer al menos una vez.  |
| `*`               | Repetición, el carácter colocado antes debe aparecer de cero a n veces. |
| `?`               | El carácter colocado antes debe aparecer una vez como máximo.           |
| `{n}`             | El carácter colocado antes debe aparecer exactamente n veces.           |
| `{n,}`            | Aparece n veces o más.                                                  |
| `{n,m}`           | Aparece entre n y m veces.                                              |
| `ˆ`               | En principio de cadena.                                                 |
| `$`               | En final de cadena.                                                     |

Únicamente "buenas tardes" y "buenas noches" empezarán por una mayúscula o una minúscula si están solos en una línea:

```bash title=""
ˆ[bB]uenas(tardes|noches)$
```

Verificación muy escueta de la validez de una dirección IP:

```bash title="Expresion regular para una IP"
echo $IP | egrep ’([0-9]{1,3}\.){3}[0-9]{1,3}’
```

Esta línea se descompone de la manera siguiente:

- `([0-9]{1,3}\.){3}`: www.xxx.yyy.
- `[0-9]`: un carácter entre 0 y 9
- `{1,3}`: repetido entre una y tres veces, por lo tanto: x, xx o xxx
- `\.`: seguido de un punto
- `{3}`: el conjunto tres veces
  Luego [0-9]{1,3}: .zzz
  - [0-9]: un carácter entre 0 y 9
  - {1,3}: repetido entre una y tres veces

### Columnas y campos

El comando `cut` permite seleccionar columnas y campos en un archivo.

#### Columnas

```bash title=" sintaxis del comando"
cut -cColumnas [fic1...]
```

Una columna es la posición de un carácter en la línea. Una línea de 80 caracteres dispone de 80 columnas. **La numeración empieza en 1**. Es el método ideal para archivos planos y con formato fijo, donde cada campo empieza y termina con posiciones dadas.
El formato de selección de columna es el siguiente:

- una columna sola (p. ej. `-c2` para la columna 2);
- un intervalo (p. ej. `-c2-4` para las columnas 2, 3 y 4);
- una lista de columnas (p. ej. `-c1,3,6` para las columnas 1, 3 y 6);
- los tres a la vez (p. ej. `-c1-3,5,6,12-`).

```bash title="Ejemplo de extración de columnas"
 cat lista
Producto    precio   cantidades
ratón       30       15
disco       100      30
pantalla    300      20
teclado     45       30
$ cut -c1-5 lista
Produ
ratón
disco
panta
tecla

```

#### Campos

El comando cut también permite seleccionar campos. Se deben delimitar estos campos por defecto
por una tabulación, pero el parámetro `-d` permite seleccionar otro carácter (espacio, ;). La selección
de los campos es idéntica a la de las columnas.

```bash title=""
cut -dc -fCampos [fic1...]
```

!!!note

      El carácter separador debe ser único.el separador por defecto es la **tabulación**

```bash title="Ejemplo"
cat lista
Producto    precio   cantidades
ratón       30       15
disco       100      30
pantalla    300      20
teclado     45       30

$ cut -f1 lista
Producto
ratón
duro
disco
pantalla
teclado
tarjeta
$ cut -f1,3 lista
Producto cantidades
ratón 15
duro 30
disco 30
pantalla 20
teclado 30
tarjeta 30

```

Si tenemos un **delimitador diferente** al tabulador como podemos observar en ejemplo.

```bash title=""
 cut -d: -f1,3 /etc/group
at:25
audio:17
avahi:106
beagleindex:107
bin:1
cdrom:20
console:21
daemon:2
dialout:16
disk:6

```

### Recuento de líneas

El comando `wc` (word count) permite contar las líneas, las palabras y los caracteres.

```bash title="sintaxis de comando"
wc [-l] [-c] [-w] [-w] fic1
 -l: cuenta el número de líneas
 -c: cuenta el número de bytes
 -w: cuenta el número de palabras
 -m: cuenta el número de caracteres

```

```bash title="Ejemplo"
$ wc lista
12
48
234 lista

```

El archivo lista contiene 12 líneas, 48 palabras y 234 caracteres.

### Ordenación de líneas

El comando `sort` permite ordenar las líneas. Por defecto, la ordenación se hace sobre toda la tabla
en orden creciente. La ordenación es posible a partir de uno o varios campos. El separador de
campos por defecto es la tabulación o, al menos, un espacio. Si hay varios campos, el primero es el
separador; los demás son caracteres del campo.

La sintaxis de sort ha evolucionado desde hace varios años y Linux ha aplicado un estándar.
Además, ya no utiliza la antigua sintaxis basada en +/-. En su lugar, hay que utilizar el parámetro -k.
La numeración de los campos empieza con 1.

```bash title="sintaxis del comando"
sort [opciones] [-k pos1[,pos2]] [fic1...]
```

```bash title="Ejemplo de utilización"
$ cat lista
ratón óptico 30 15
duro 30giga 100 30
duro 70giga 150 30
disco zip  12  30
disco blando 10 30
pantalla 15 150 20
pantalla 17 300 20
pantalla 19 500 20
teclado 105 45 30
teclado 115 55 30
tarjeta sonido 45 30
tarjeta vídeo 145 30


```

A continuación vemos cómo ordenar por orden alfabético a partir de la primera columna:

```bash title="Ejemplo.Ordenación"
sort -k 1 lista
disco blando 10 30
disco zip 12 30
duro 30giga 100 30
duro 70giga 150 30
pantalla 15 150 20
pantalla 17 300 20
pantalla 19 500 20
ratón óptico 30 15
tarjeta sonido 45 30
tarjeta vídeo 145 30
teclado 105 45 30
teclado 115 55 30

```

Algunos parámetros

| Opción | Función                                                                                                                  |
| ------ | ------------------------------------------------------------------------------------------------------------------------ |
| `-d`   | Dictionnary sort (ordenación de diccionario).Sólo toma como criterio de ordenación las letras,las cifras y los espacios. |
| `-n`   | Ordenación numérica, ideal para las columnas de cifras.                                                                  |
| `-b`   | Ignora los espacios al principio del campo.                                                                              |
| `-f`   | No hay diferencias entre mayúsculas y minúsculas (conversión en minúsculas y luego ordenación).                          |
| `-r`   | Reverse, ordenación en orden decreciente.                                                                                |
| `-tc`  | Nuevo delimitador de campo c                                                                                             |

```bash title="Ejemplo: ordenación numérica a partir de los precios por productos en orden decreciente"
sort -n -r -k 3 lista

pantalla 19 500 20
pantalla 17 300 20
pantalla 15 150 20
duro 70giga 150 30
tarjeta vídeo 145 30
duro 30giga 100 30
teclado 115 55 30
teclado 105 45 30
tarjeta sonido 45 30
ratón óptico 30 15
disco zip 12 30
disco blando 10 30

```

También es posible ejecutar la ordenación desde un determinado carácter de un campo. Para ello,
debe especificar el `".pos": -k1.3` empezará la ordenación a partir del tercer carácter del campo 1.

### Eliminación de las líneas repetidas

El comando `uniq` permite suprimir las líneas repetidas en flujos de entrada o archivos ordenados.
Por ejemplo, a continuación se muestra cómo sacar únicamente la lista de los **GID** realmente
utilizados como grupo principal de usuarios:

```bash title="Ejemplo. Eliminación de líneas repetidas"
cut -d: -f4 /etc/passwd | sort -n | uniq
0
1
2
7
8
12
13
14
25
49

```

### Sustitución de caracteres

El comando `tr` permite sustituir unos caracteres con otros y sólo acepta datos que provengan del
canal de entrada estándar, no de los archivos.

```bash title="Sintaxis de tr"
tr [opciones] original destino
```

El original y el destino representan uno o varios caracteres. Se sustituyen los caracteres originales
con los de destino en el orden indicado. Los corchetes permiten definir intervalos.

```bash title="sustituir la o por la e y la i por la a:"
cat lista | tr "oi" "ea"

Predut ebjete precie cantadades
raten  éptaque 30 15
dure 30gaga 100 30
dure 70gaga 150 30
dasce zap 12 30
dasce blande 10 30
pantalla 15  150 20
pantalla 17  300 20
pantalla 19 500 20
teclade 105 45 30
teclade 115 55 30
tarjeta senade 45 30
tarjeta vadee 145 30

```

```bash title="Ejemplo. convertir una cadena en mayúsculas o en minúsculas"
 cat lista | tr "[a-z]" "[A-Z]"
PRODUCTO OBJETO PRECIO CANTIDADES
RATÓN ÓPTICO 30 15
DURO 30GIGA 100 30
DURO 70GIGA 150 30
DISCO ZIP 12 30
DISCO BLANDO 10 30
PANTALLA 15 150 20
PANTALLA 17 300 20
PANTALLA 19 500 20
TECLADO 105 45 30
TECLADO 115 55 30
TARJETA SONIDO 45 30
TARJETA VÍDEO 145 30

```

Sobre todo, `tr` admite dos parámetros,` -s (squeeze)` y `-d (delete)`, que permiten suprimir caracteres,
duplicados o no.

A continuación damos un ejemplo práctico en el cual se busca aislar la dirección IP de una máquina.

```bash title="Ejemplo.Aislar la dirección ip"

ip a

2: enp7s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 8c:16:45:ec:03:2d brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.11/24 brd 192.168.0.255 scope global dynamic noprefixroute enp7s0
       valid_lft 84531sec preferred_lft 84531sec
    inet6 fe80::3ff2:8996:7beb:c511/64 scope link noprefixroute
       valid_lft forever preferred_lft forever

# Nos muestra esta salida, solo queremos la ip del interfaz correspondiente. Para ello vamos a realizar algunas transformaciones.

# Como hacemos un filtro sobre el interfaz nos dan dos lineas por eso hay que convertirla en una linea quitándole el final de linea \n.

ip a | grep enp7s0 |tr -s "\n" " "|  tr -s " " ":" |  cut -d: -f15


```

Otros comandos útiles en la sustitución de caracteres son: el comando `expand` convierte las tabulaciones en espacios y el comando `unexpand` convierte los espacios en tabulaciones. Aunque la acción de estos comandos se puede realizar con el comando tr. Sabiendo que, la tabulación es '\t'.
