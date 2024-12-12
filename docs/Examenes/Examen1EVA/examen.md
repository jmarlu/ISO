# Examen de la Primera Evaluación

Tienes que generar un fichero PDF por cada uno de los ejercicios que tienes y a continuación subirlo a "Aules" en la tarea correspondiente. Describiendo detalladamente con **capturas de pantalla y explicaciones** de cada uno de los pasos.

## Ejercicio 1 (30% del RA1)

Añade un disco duro a la máquina virtual en el mismo controlador SATA de 20G. Además, amplia a tres los núcleos de la CPU disponibles para tu máquina.

## Ejercicio 2 (50% del RA2)

1. Introduce un comando para mostrar **SOLO** el PID y nombre de todos los procesos de tu usuario, en todo el sistema.
2. Busca todos los **correos-e** que hay en todo el sistema de ficheros.(Crea un fichero con un correo-e)
3. Introduzca un comando para contar el número de ficheros del sistema que **pertenezcan a tu usuario**, sean mayores de 200KB y que tengas tú permiso de escritura. El resultado debe almacenarse en el fichero res3, es decir el número de fichero que hay, y los errores en el fichero err3.
<!--
soluciones:
1>ps -fe -u usuario | tr -s' ' ' ' | cut -d ' '-f2,8

2> find / -type f -exec egrep "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$" {} \; (Hay otra solución con el grep -R)
3> find / -type f -size +200k -user root -writable 2>err3 | wc -l > res3
-->

## Ejercicio 3 (50% del RA3)

1. Crea una tarea con systemd.timer, que se lance el 10 de diciembre de 2024, consistente en contar el número de ficheros mayores de 2MB, del usuario root. El resultado de este comando debe almacenarse en el fichero `~/ej1`
2. Configurar el sistema para montar en el arranque, la partición `/dev/sdb` en el directorio `~/D2`,**sobre el disco duro anteriormente montado**, en **modo lectura y escritura** de forma que **no** se permita la ejecución de programas de dicha partición. Además debe chequearse periódicamente la partición en el arranque del sistema.¿Cómo vemos todos los elementos que tenemos montados?
3. Para el servicio SSH y asegúrate de que no se ejecuta durante el inicio del sistema.(reinicia la máquina). Vuelve a activarlo.(primero tendrás que verificar que tengas ese servicio y si no lo tendrás que instalar en el contenedor)
