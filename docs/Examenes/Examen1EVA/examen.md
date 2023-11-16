# Examen de la Primera Evaluación

Tienes que generar un fichero PDF por cada uno de los ejercicios que tienes y a continuación subirlo a "Aules" en la tarea correspondiente.

## Ejercicio 1 (23% del RA1)

Lance un contenedor con Ubuntu (la última versión) tenga por nombre u1 y lance un shell para trabajar en él durante todos los ejercicios siguientes.

<!-- Solution:sudo lxd init;lxc launch ubuntu\:22.04 u1; lxc shell u1} -->

## Ejercicio 2 (50% del RA2)

1. Introduce un comando para mostrar **SOLO** el PID de todas las consolas modo texto (tty) existentes en el sistema.
2. Busca todos los **correos-e** que hay en todo el sistema de ficheros.(Crea un fichero con un correo-e)
3. Introduzca un comando para contar el número de ficheros del sistema que pertenezcan a tu usuario, sean mayores de 200KB y que tengas permiso de escritura. El resultado debe almacenarse en el fichero res3 y los errores en el fichero err3.

## Ejercicio 3 (50% del RA3)

1. Crea una tarea con systemd.timer, que se lance el 10 de diciembre de 2023, consistente en contar el número de ficheros mayores de 2MB, del usuario root. El resultado de este comando debe almacenarse en el fichero ~/ej1
2. Configurar el sistema para montar en el arranque, la partición /dev/sdb en el directorio ~/D2, en **modo lectura y escritura** de forma que **no** se permita la ejecución de programas de dicha partición. Además debe chequearse periódicamente la partición en el arranque del sistema.¿Cómo vemos todos los elementos que tenemos montados? (Este ejercicio es teórico , no lo podemos comprobar )
3. Para el servicio SSH y asegúrate de que no se ejecuta durante el inicio del sistema.(para el contenedor y vuelve a iniciarlo). Vuelve a activarlo.
