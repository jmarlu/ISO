# Compresión de datos.

Una forma de optimizar la capacidad de almacenamiento en una unidad es usar la compresión. Se puede activar la compresión de un volumen NTFS o configurar carpetas y archivos individuales para comprimir. La compresión no es recomendable en discos cuyo tamaño de clúster es mayor de 4 KB, debido a que el ahorro de espacio no compensa la pérdida de rendimiento y el impacto en el sistema que se produce. También es preciso señalar que la cantidad de espacio ahorrada depende del tipo y el tamaño de archivos a comprimir.

El comportamiento de los archivos comprimidos a través de este sistema, es diferente en función de la acción que se realiza sobre ellos:

- si se mueve un archivo sin comprimir a una carpeta, **el archivo permanece sin comprimir**, independientemente del atributo de compresión de la carpeta.
- si se mueve un archivo comprimido a una carpeta, **el archivo permanece comprimido**, independiente del atributo de compresión de la carpeta.
- si se copia un archivo a una carpeta, **éste toma el atributo de compresión de la carpeta destino**.
- si se sobrescribe un archivo, el nuevo **toma el atributo de compresión** de su predecesor.

Además, hay que tener en cuenta varios factores sobre la compresión:
los archivos están descomprimidos al ser transferidos por la red, de modo que no se obtienen beneficios en el uso del ancho de banda en transmisiones telemáticas.

- comprimir ciertos tipos de archivos ya comprimidos como **jpg, zip, rar, 7z** entre otros, puede ser contraproducente y generar archivos mayores que los originales.

Un servidor puede experimentar una degradación importante cuando se usa compresión. En general, los servidores con poca carga de trabajo o los que **son principalmente para lectura** son los más apropiados para la compresión, ya que no sufrirán tanta degradación como los que tienen gran carga de trabajo o muchas operaciones de escritura.

La única forma de determinar como afectará la compresión a un sistema, es mediante el ensayo-error. Hay que exigir una relación óptima entre espacio ganado y consumo de recursos que permita la justificación de la compresión. Si no se ahorra tanto espacio como el esperado o el rendimiento se degrada significativamente, sencillamente no es una buena opción y es suficiente con descomprimir el volumen o las carpetas comprimidas.

Para activar la compresión en sistemas operativos de Microsoft existe un atributo en los volúmenes que permite comprimir su contenido. Disponen de dos formas de activar la compresión:

- al formatear un volumen, será necesario activar la casilla de verificación <span class="menu">Habilitar compresión de archivos y carpetas</span>.
- activar o desactivar la compresión de un volumen ya formateado. Hay que acceder a la propiedades del volumen y en la pestaña <span class="menu">General</span>, seleccionar la opción <span class="menu">Comprimir esta unidad para ahorrar espacio en disco</span>. Tras la activación del atributo, el asistente preguntará si se desea comprimir sólo la carpeta raíz, o todos los archivos y carpetas.

El proceso de descompresión pasa por desactivar estos atributos de la misma manera que se activaron.

También existe la posibilidad de comprimir archivos determinados y no todo un volumen. Para comprimir/descomprimir un archivo se accede a sus propiedades, a través de la pestaña <span class="menu">General</span> → <span class="menu">Avanzados…</span>, en el diálogo siguiente se elegirá la opción <span class="menu">Comprimir contenido para ahorrar espacio en disco</span>.

En los sistemas operativos GNU/Linux, al igual que en los de Microsoft, la compresión de volúmenes se realiza a través del sistema de ficheros que tenga asignado y _ext3_ como _ext4_ no permiten la compresión. Hay dos sistemas de ficheros que lo permiten y son utilizables en GNU/Linux:

- **ZFS (Zettabyte File System)**, está desarrollado por Sun Microsystems para el sistema operativo Solaris y no viene incluido con ninguna de las grandes distribuciones de GNU/Linux, aunque es posible instalarlo y usarlo en Ubuntu Server.
- **BTRFS (B TRee File System)** que está incluido de forma experimental en la versión 2.6.29 del núcleo de GNU/Linux. Es compatible con varios métodos de compresión como LZO (Lempel Ziv Oberhumer) especializado en la compresión rápida de ficheros.

No es esta una tarea para la que GNU/Linux esté diseñado, o mejor dicho, sus sistema de ficheros. Existen alternativas que, más pronto que tarde, serán opciones viables en estos sistemas operativos.
