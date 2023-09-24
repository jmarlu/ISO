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
