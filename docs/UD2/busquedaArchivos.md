# Búsqueda de ficheros en el sistema

Todos los sistemas de ficheros ofrecen la función de búsqueda de archivos dentro del dispositivo o dispositivos que lo conforman. Habitualmente, los sistemas operativos disponen de una aplicación GUI para realizar esta tarea y que no entraña ninguna dificultad a la hora de su manejo. Además de esto, los sistemas operativos basado en GNU/Linux disponen de una potente herramienta en el terminal.

El comando `find`, uno de los legendarios de los sistemas Unix y por supuesto de las distribuciones GNU/Linux. Permite realizar todo tipo de búsquedas de ficheros tanto por su nombre como por cualquiera de sus atributos. Existen numerosas opciones de búsqueda y combinaciones posibles, pero para eso disponemos de la ayuda en el terminal. Aún así, se tratarán algunas opciones más comunes.

El uso genérico de `find` es el siguiente:

```bash title="Buscar"
find [ruta] [expresión_de_búsqueda] [acción]
```

El comportamiento por defecto del comando find es buscar de forma recursiva a partir de la dirección establecida en su primer parámetro. Para limitar esos resultados se utiliza la opción -maxdepth. Por ejemplo, se limita la búsqueda en el directorio de primer nivel

```bash title="Ejemplo de find"
find /srv/www/web -maxdepth 1 -name "*.js"
```

Se puede indicar a find que busque en varios directorios dándole cada uno de ellos como argumentos

```bash title="Ejemplo de find"
find /home/feo /tmp/project -name "feo"
```

o utilizar metacaracteres para buscar archivos en caso de no conocer los nombres exactos

```bash title="Ejemplo de find"
find . –name "\*feo"
```

Las opciones que ofrece `find` son numerosas, entre ellas destacan:

`-perm`: hace que se busquen archivos que tienen un patrón particular de permisos representados en octal. Esto permite detectar archivos que no tienen los permisos que deberían y que pueden suponer una amenaza para la seguridad del sistema. También se dispone de opciones más sencillas como `-readable`, `-writable` y `-executable`, aunque también es posible usar el parámetro `-perm` a partir del cual podemos establecer esos tres permisos a la vez, como ilustra el siguiente ejemplo:

```bash title="Ejemplo de busqueda con permisos determinados"
find /home/Feo -type f -perm -110
```

Con este comando se obtendrían ficheros con el bit del permiso ejecutable activado para el usuario y el grupo. El símbolo guion “-” le indica que ignore otros bits. No importa si el fichero es de lectura o de escritura, lo esencial es que aparezcan todos los que tienen ese bit de ejecución. Si es necesario que específicamente se busquen ficheros que tengan el bit ejecutable para usuario, se prescinde del guion “-“.
`-user` ,`-uid`: restringe la búsqueda a archivos que pertenecen a un usuario en concreto. En este último caso requiere conocer el identificador de un usuario, algo poco usual. Además se puede buscar ficheros que pertenecen a un usuario A o a un usuario B con el parámetro `-or`, con lo que escribiríamos:

```bash title="Ejemplo de busqueda con usuarios determinados"
find / -user root -or -user Feo
```

También existen los operadores lógicos -`and` y `-not` para realizar búsquedas más precisas. Además de por usuario, también es posible buscar ficheros que pertenezcan a un determinado grupo a través de la opción `-group`.

`-name <expresión>` permite especificar patrones para los nombres de los ficheros a buscar.
`-iname <expresión>` permite especificar patrones para los nombres de los ficheros a buscar sin tener en cuenta mayúsculas y minúsculas.
`-type <tipo>` permite indicar el tipo de fichero a buscar. Éste puede ser d para directorios y f para ficheros regulares.

Otra de las posibilidades que ofrece `find` es buscar ficheros por su fecha de creación, acceso o modificación. Por tiempo de acceso con `-atime`, por última modificación con `-mtime` o por el último cambio de fichero `-ctime`. Todas las cifras de búsqueda se expresan en días. Por ejemplo, ficheros que hayan sido modificados en los dos últimos días

```bash title="Ejemplo de busqueda con parámetros de tiempo"
find /home/Feo -mtime -2
```

Es posible combinar las opciones y buscar ficheros en un rango, por ejemplo, ficheros que tengan entre 2 y 5 días desde su última modificación

```bash title="Ejemplo de busqueda con parámetros de tiempo"
find -mtime -2 -mtime +5
```

También se dispone de opciones para buscar por fracciones temporales de minuto con `-amin, -cmin y -mmin,` análogas a las anteriores.

`-size +/-<n>` permite indicar el tamaño máximo y/o mínimo de los ficheros a buscar. Por defecto el tamaño se expresa en bloques de 512 bytes, pero si se precede este por un carácter c se referirá a bytes, k a kilobytes, w a palabras de dos bytes y b a bloques.

```bash title="Ejemplo de busqueda con parámetros de tamaño"
find /home/Feo -size 100k
```

Esto permitiría buscar ficheros con un tamaño exacto de 100 kilobytes. Es probable que lo que se requiera es encontrar ficheros con un tamaño superior o inferior a esa cifra en cuyo caso se usa el signo + para ficheros mayores y el signo – para menores. Es posible buscar en gigabytes, basta con poner 100G, o 100M para megabytes.

`-exec <comando>` pero si en donde find demuestra su potencial es poder combinarlo con otros comandos para construir sinergias y facilitar tiempo de administración. Tras encontrar los ficheros, se realizará el comando especificado en la opción -exec, una vez por cada ocurrencia encontrada en la búsqueda. De este modo, por ejemplo, es posible modificar el propietario de los ficheros de una carpeta personal

```bash title="Ejemplo de busqueda ejecutando un comando"
find /home/Feo -user root -exec chown Feo {} \;
```

Este comando ejecuta el comando `chown Feo` por cada fichero encontrado. El símbolo de llaves “{}” especifica el conjunto de los resultados obtenidos y sobre los que va a realizar la acción. Las llaves han de colocarse en la posición que ocuparía el fichero que recibe la acción, que dependerá del comando a utilizar.

Con `find` es posible encontrar archivos con una mayor precisión que con cualquier software con interfaz gráfica y además permite la ejecución de comandos accesorios, ampliando aún más si cabe su potencial.
