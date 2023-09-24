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
!!! example inline end "mv"

      `mv <origen> <destino>` (move). Comando para mover ficheros desde un origen a un destino especificado.

Es posible redireccionar estos canales hacia archivos o flujo de texto de manera transparente para
los comandos Linux.

### De salida

Se puede utilizar el carácter `>` para redireccionar la salida estándar (la que va normalmente en la
pantalla). Luego se indica el nombre del archivo donde se colocarán los resultados de salida.

```bash title=""

$ ls -l > resultado.txt

```

**El shell empieza primero por crear el archivo y luego ejecuta el comando.**

!!!warning

      **Es un aspecto importante de las redirecciones**: se interpretan las redirecciones de derecha a izquierda, y se instalan las redirecciones ANTES de la ejecución de los comandos. Hay que crear el archivo antes de poder escribir en él. De ahí que, incluso si el comando es falso, se crea o se "chafa" el archivo...

Para añadir datos a continuación del archivo, o sea, sin sobreescribirlos, se utiliza la doble redirección `>>`. Se añade el resultado del comando al final del archivo.

```bash title="Ejemplo añadir"
ls -l > resultado.txt
 date >> resultado.txt
```

### En entrada

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
