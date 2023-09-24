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

## Encadenar los comandos

Puede ejecutar varios comandos en una sola línea, unos tras otros. Para ello, basta con separarlos con un punto y coma.

```bash title="Encadenar comandos"
 date;pwd;cal

```

## Obtención de ayuda en un terminal

!!! example inline end "Exit"

      Comando que cierra y sale del terminal actual. Si hay procesos iniciados desde el terminal, también se cerrarán.

Queda lejos de la intención de esta unidad de trabajo la explicación de todos los comandos del sistema GNU/Linux así como de sus modificadores u opciones. Existen varios métodos de obtener ayuda sobre un comando para no tener que recordar cientos de opciones de cada comando:

- usar el **modificador** `--help`, ofrecerá una guía rápida de uso y de los modificadores más utilizados del comando.
- usar el comando `man`, el cual imprimirá una guía de uso del comando. Su uso es sencillo, basta con anteponer man al comando sobre el que se requiera información.
- Usar `info` es similar a `man`, pero las páginas están estructuradas, ofrecen vínculos, un índice, una jerarquía o menús. Las páginas info pueden llamarse entre ellas y ofrecen frecuentemente una navegación amigable.

### El manual en línea. Man

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

!!!example Algunos atajos útiles

      Se deben conocer algunas secuencias de atajos de comandos:

        - ++ctrl+C: interrupción del programa: se termina.
        - ++ctrl+Z: para el programa (ver los procesos).
        - ++ctrl+D: interrumpe una introducción de datos en un símbolo del sistema >.

## El historial de comandos

Le resultará muy útil poder volver a llamar a un comando que ya ejecutó navegando por el historial
de los comandos con las teclas ++arrow-up++ y ++arrow-down++. La flecha arriba vuelve atrás en el
historial. Si ha tecleado los dos comandos anteriores (`date` y luego `pwd`), al presionar una primera
vez en la flecha arriba se visualiza en la línea de comandos pwd, y a la segunda se visualiza el
comando date. La flecha abajo navega en el otro sentido hasta la línea de origen. Si pulsa la tecla
++enter++ vuelve a ejecutar el comando.

Puede ver el contenido del historial con el comando `history`. El resultado siguiente está truncado de manera
voluntaria, ya que la lista es demasiado larga.

```bash title="Ejemplo de history"
 history
 1000  code
 1001  code .
 1002  [aula3]
 1003  192.168.3.[1:22]
 1004  [aula3:vars]
 1005  ansible_network_os=aula3
 1006  ansible-playbook  deploy.yml
 1007  ping 192.168.1.113
 1008  cd ansible-demo/
```
