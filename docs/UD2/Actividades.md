# Actividades de la UD2

## Actividad 1. Introducción Terminal

Accede al Moodle del módulo y realiza la _RELACIÓN 2-I de ejercicios_ de comandos que allí se detallan.

## Actividad 2. Desarrollo de la terminal

Accede al Moodle del módulo y realiza la _RELACIÓN 2-II de ejercicios_ de comandos que allí se detallan. Escribir los comandos y enviarlos,**a posteriori yo los corregiré**. Para hacer este cuestionario tenéis só 45 minutos.

## Actividad 3. Describe

Describe, de forma resumida, cuáles son las funciones de cada carpeta en el modelo Filesystem Hierarchy Standard utilizado por los sistemas operativos GNU/Linux, y su correlación (si existiese) con los sistemas operativos de MIcrosoft.

## Actividad 4. Desarrollo

1. Los servidores cuentan con varios discos duros instalados en la unidad anterior. En los segundos discos de los SOR, crea una tabla de partición MBR con tres particiones de aproximadamente el mismo tamaño cada una. En Microsoft Windows Server realiza esta tarea a través de **GUI** y en Ubuntu Server con **CLI** y el comando `fdisk`.
2. Asigna un sistema de ficheros adecuado a cada partición. Recuerda que en Ubuntu Server será necesario realizar esta tarea a través de CLI con el comando `mkfs`.
3. Monta las particiones creadas en el punto anterior en las carpetas **Datos, Perfiles y Cifrado**. Crea las carpetas donde estimes oportuno. Esta configuración se realizará tanto en GNU/Linux como en Microsoft Windows.
4. Realiza los cambios necesarios para que las carpetas citadas en el ejercicio anterior se monten de forma automática durante el arranque de Ubuntu Server. Para ello deberás modificar el fichero fstab.
5. Modifica el gestor de arranque del sistema operativo Ubuntu Desktop para que tan sólo ofrezca dos opciones de arranque; Arranacar el sistema con Ubuntu y Prueba de memoria. Las opciones deben tener estos nombres por pantalla.

## Actividad 5. Dual

6. En esta práctica se van a instalar dos sistemas operativos en una misma máquina virtual (y disco duro). Debemos crear un sistema de arranque que nos permita elegir el sistema operativo con el que deseamos arrancar nuestro equipo. Para ello, sigue los pasos que se describen a continuación. 1. Crea una máquina virtual denominada “Dual” que tenga un disco duro virtual de 1 TB en expansión dinámica, y una memoria principal de 1024 MB:

   - Particiona el disco para contener un sistema operativo cliente de Microsoft, uno basado en GNU/Linux y dos particiones de datos, con los nombres **DOCUMENTOS y EXPEDIENTES** que podrán ser accedidas sea cual sea el sistema operativo que se arranque. Crea un esquema con las particiones, su tamaño y el sistema de archivos que se usará en cada caso. El particionado se realizará con el sistema MBR.

   - Instala los sistemas operativos en el siguiente orden: **Microsoft Windows 10 Professional o Microsoft Windows 7 Professional y Ubuntu Desktop**.
   - Al finalizar la instalación, debe quedar un menú de inicio con varios sistemas operativos. Recuerda que si pulsas la tecla ESC durante el arranque de la máquina virtual, podrás acceder al menú **GRUB**.
   - Una vez instalados los sistemas operativos en el mismo disco duro, modifica el **GRUB** de para que el sistema operativo a iniciar por defecto sea el de Microsoft y que espere 15 segundos antes de iniciarlo. Realiza esta tarea en CLI.

## Actividad 6. De Ampliación

Conecta un nuevo disco duro a la máquina que contiene el sistema operativo de red **Ubuntu Server**. Su tamaño será de **1TB** y de expansión dinámica. A través del CLI, realiza las siguientes tareas:

- Crea dos particiones primarias; la primera con 700 GB y el resto con 300 GB de capacidad (valores aproximados)
- Haz que la primera partición creada contenga los directorios personales de usuario. Para ello sigue este procedimiento:

  - Crea un directorio temporal `/mnt/home_temporal` y monta en ella el primer volumen creado.
  - Copia todos los ficheros del `/home` actual al directorio temporal `/mnt/home_temporal`. Comprueba que la copia de los archivos se ha realizado correctamente, incluyendo los permisos correspondientes. Consulta la ayuda del comando cp para usar un modificador que mantenga los atributos de archivo.
  - Desmonta el directorio temporal `/mnt/home_temporal`
  - Edita el archivo fstab para incluir el nuevo punto de montaje de `/home`

- Repite los pasos anteriores para la carpeta `/tmp` en la segunda partición. En esta ocasión no será necesaria la copia de ficheros al tratarse de archivos temporales.

## Actividad 7. De Refuerzo

1. En este ejercicio se va a crear un repositorio de almacenamiento para las publicaciones de la empresa que, más tarde, será compartido a todos los usuarios del directorio. Para ello sigue los pasos que se detallan a continuación:

- Añade un nuevo disco duro a la máquina virtual que contiene el sistema operativo **UbuntuServer**. Debe ser de 500 GB, de expansión dinámica y añadido al controlador SATA.
- Crea una partición primaria con el sistema GPT. Para esta tarea usa el comando `fdisk` y sigue las instrucciones que se detallan en el asistente. Una vez creada, asigna el sistema de ficheros ext4 con el comando mkfs. Consulta la ayuda de este comando si no recuerdas cómo hacerlo.
- Crea la carpeta publicaciones en el directorio /mnt/Publicaciones. Para ello usa el comando `mkdir`. Recuerda que deberás hacer estas tareas con una cuenta con permisos de administración.
- Monta la partición recién creada en la carpeta /mnt/Publicaciones con el comando `mount`. Comprueba que tienes acceso.
- Edita el fichero fstab para que el montaje sea permanente. Para ello abre el fichero con el comando

  ```bash title=""
  sudo nano /etc/fstab/
  ```

  y añade al final la línea de texto

  ```bash title=""
    /dev/sdc1 /mnt/Publicaciones ext4 defaults 0 2

  ```

  Explica qué significa cada una de las palabras que has escrito en este fichero.

- Reinicia el equipo y comprueba que la configuración funciona de forma correcta con el comando `lsblk`.

2. Edita el fichero /etc/default/grub de la máquina virtual “Dual” para realizar estos cambios:

   - Abre el fichero con el editor de texto nano y busca la línea **GRUB_DEFAULT=0**. Sustituye el cero por un 3. ¿Qué significa esta configuración?. ¿Qué número se debería colocar para que el primer sistema operativo en arrancar sea el de Microsoft?.
   - Modifica la linea **GRUB_TIMEOUT=10** por **GRUB_TIMEOUT=5**. ¿Qué quiere decir esta configuración?. ¿Qué número debo colocar si quisiera no esperar nada para el inicio de la secuencia de arranque?.
   - Reinicia la máquina y comprueba que los cambios han surtido efecto.

!!! note annotate "Manera de entrega de las actividades"

      Redacta una guía de los pasos a seguir para realizar esta actividad y súbela al **Moodle** del módulo.
      De tal forma que en cada uno de los pasos incluya una imagen que **verifique** que se ha realizado aquello que se pide en cada uno de los ejercicios. Como en las anteriores actividades

!!! warning

      **SOLO LAS ACTIVIDADES 1,2,3,4,5 SON OBLIGATORIAS.**
