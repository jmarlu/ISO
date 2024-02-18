# Comparadores.

## Comparadores Aritméticos.

<center>

| Comparador    | <center> Significado </center>      |
| :----: | :-- |
| `-eq`   | Igual a (Equeal to)        |
| `-ne` | No Igual (Not Equal)    |
| `-gt`    | Mayor que (Greater Than)    |
| `-ge`     | Mayor o igual (Greater or Equal)       |
| `-lt`     | Menor que (Lower Than)   |
| `-le`     | Menor o igual (Lower or Equal)    |

</center>

### Ejemplo 1

``` bash
if [ $edad -gt 25 ]
then
	echo "Tienes más de 25 años."
else
	echo "Tienes 25 o menos años."
fi
```

### Ejemplo 2

``` bash
if [ $examenes -ne 20 ]
then
	echo "No tenemos exactamente 20 exámenes entregados, algo ha ido mal"
else
	echo "Han entregado 20 exámenes."
fi
```

### Ejemplo 3

``` bash
if [ $memoria -le 100000 ]
then
	echo "Quedan 100MB o menos en el sistema."
fi
```

## Comparadores de Archivos.

<center>

| Comparador    | <center> Significado </center>      |
| :----: | :-- |
| `-f`   | Verdadero si es un fichero      |
| `-e` | Verdadero si existe   |
| `-d`    | Verdadero si es un directorio    |
| `-r`     | Verdadero si tengo permisos de lectura     |
| `-w`     | Verdadero si tengo permisos de escritura   |
| `-x`     | Verdadero si tengo permisos de ejecución   |
| `-O`     | Verdadero si soy el usuario propietario  |
| `-G`     | Verdadero si pertenezco al grupo propietario   |
| `-s`     | Verdadero si el fichero NO está vacío    |
| `-L`     | Verdadero si se trata de un enlace simbólico   |

</center>

### Ejemplo 1

``` bash
if [ -e $carpeta ]
then
	echo "La carpeta existe, aunque quizá se trate de un fichero."
else
	echo "La carpeta no existe"
fi
```

### Ejemplo 2

``` bash
if [ -d $carpeta ]
then
	echo "La carpeta existe y se trata seguro de una carpeta."
else
	echo "La carpeta no existe"
fi
```

### Ejemplo 3

``` bash
if [ -s $fichero ]
then
	echo "El fichero contiene información."
else
	echo "El fichero está vació y lo voy a borrar."
	rm -f $fichero
fi
```


## Comparadores de cadenas / variables.

<center>

| Comparador    | <center> Significado </center>      |
| :----: | :-- |
| `=`   | Verdadero si es igual      |
| `!=` | Verdadero si es diferente |
| `-n`    | Verdadero si la variable tiene contenido  |
| `-z`     | Verdadero si la variable está vacía    |

</center>

### Ejemplo 1

``` bash
if [ $usuario = "ajc" ]
then
	echo "Bienvenido Alejandro!"
else
	echo "¿Quién eres?"
	read -p "Introduce tu nombre: " nombre
fi
```

### Ejemplo 2

``` bash
if [ $salir != "s" ]
then
	echo "El usuario quiere seguir jugando."
else
	echo "El usuario quiere continuar jugando."
fi
```

### Ejemplo 3

``` bash
if [ -z $respuesta]
then
	echo "Hubo algún error y se ha recibido una respuesta vacía"
fi
```