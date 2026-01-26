---
search:
  exclude: true
---
# Examen de la Primera Evaluación

Tienes que generar un fichero PDF por cada uno de los ejercicios y, a continuación, subirlo a "Aules" en la tarea correspondiente. Describe detalladamente cada paso con **capturas de pantalla y explicaciones**.

## Ejercicio 1 (55% del RA1)

Añade un disco duro de 20G a la máquina virtual en el mismo controlador SATA. Además, amplía a tres los núcleos de la CPU disponibles para tu máquina.

## Ejercicio 2 (100% del RA2)

1. Introduce un comando para mostrar **SOLO** el PID y el nombre de todos los procesos de tu usuario, en todo el sistema.
2. Busca todos los **correos-e** que haya en todo el sistema de ficheros (crea un fichero con un correo-e para comprobarlo). Los correos-e pueden incluir los caracteres `._%+-`, números y letras minúsculas o mayúsculas.
3. Introduce un comando para contar el número de ficheros del sistema que **pertenezcan a tu usuario**, sean mayores de 200KB y tengas permiso de escritura. El resultado debe almacenarse en el fichero `res3` (solo el número de ficheros) y los errores en el fichero `err3`.
<!--
soluciones:
1> ps -fe -u usuario | tr -s' ' ' ' | cut -d ' ' -f2,8

2> find / -type f -exec egrep "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" {} \; (hay otra solucion con el grep -R)
3> find / -type f -size +200k -user usuario -writable 2>err3 | wc -l > res3
-->

## Ejercicio 3 (75% del RA3)

1. Crea una tarea con systemd.timer que se lance el **10 de diciembre de cualquier año**. La tarea consistira en contar el numero de ficheros mayores de 2MB del usuario root. El resultado de este comando debe almacenarse en el fichero `~/ej1`.
2. Configura el sistema para montar en el arranque la particion `/dev/sdb` (o la particion que corresponda, p. ej. `/dev/sdb1`) en el directorio `~/D2`, **sobre el disco duro anteriormente montado**, en **modo lectura y escritura**, de forma que **no** se permita la ejecucion de programas de dicha particion. Ademas debe chequearse periodicamente la particion en el arranque del sistema. ¿Como vemos todos los elementos que tenemos montados?
3. Para el servicio SSH, si no esta deberas instalar el paquete `openssh-server`, y asegurate de que no se ejecuta durante el inicio del sistema (reinicia la maquina). Vuelve a activarlo. (Primero tendras que verificar que tengas ese servicio y, si no, lo tendras que instalar en la maquina.)
