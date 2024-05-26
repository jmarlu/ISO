# Actividades

## INTRODUCCIÓN

1. Realiza una planificación de las copias de seguridad de la empresa que generaste con al menos dos copias de seguridad. Debe responder a a las siguiente preguntas:
   - ¿Qué tipos de copia de seguridad debo utilizar?
   - ¿Qué ficheros debo incluir en cada una de las copias de seguridad?
   - ¿Con qué periodicidad se realizarán las copias de seguridad?
   - ¿Se realizarán de forma automática o manual?. ¿Cuál será su programación?
   - Si falla el sistema, ¿en cuánto tiempo se podrán recuperar las copias?
   - ¿En qué tipo de dispositivos se realizarán las copias de seguridad?

Elabora un documento con la planificación de las copias de seguridad

2.  Instala la característica Copias de seguridad de Windows Server en ServidorWindows y configura estas dos copias de seguridad. Para ello deberás añadir dos discos duros de 1 TB al servidor, uno para cada copia

    - programa una copia de seguridad incremental del sistema operativo que se ejecutará de forma diaria a las 2:00 hora
    - programa una copia incremental de las carpetas Datos y Perfiles cada 4 horas empezando a las 8:00 horas.
      !!! warning
      si se nota que el rendimiento se resiente, elimina los volúmenes RAID creados con anterioridad y reutiliza esos discos.

    Elabora una guía con las configuraciones que sigues para realizar esta tarea y, una vez revisada.

## DESARROLLO

3.  Utilizando `rsync`, haz una copia del sistema de ServidorUbuntu en un nuevo volumen contenido en un disco duro instalado a tal efecto. Este nuevo disco estará montado en `/media/Seguridad` y la copia tendrá las siguientes característica

    - serán excluidas las carpetas `/dev, /proc, /sys, /tmp, /mnt, /swap y /med`
    - los archivos copiados deben disponer de **los mismos permisos y pertenencia a grupo**
    - la copia debe estar **comprimida**
    - se ejecutará todos los días a la 2:00 horas

4.  Simula la pérdida de datos (borrando alguno de ellos) y recupera las copias de seguridad tanto en ServidorWindows como en ServidorUbuntu. Realiza una pequeña memoria con los para que sigues para realizar esta tarea.
5.  Elimina las copias de seguridad realizadas en los ejercicio anteriores e implanta en ServidorWindows y ServidorUbuntu las copias diseñadas en la planificación que has realizado. Detalla los pasos que sigues en un documento y súbelo al Moodle del módulo cuando lo revises.
6.  Crea una imagen del cliente CW1001 con Clonezilla siguiendo los siguientes pasos:

- instala un nuevo disco duro con capacidad suficiente para contener el volumen C:\ de esta máquina.
- arranca el sistema y crea una tabla de particiones con una única partición primaria
- inicia la máquina virtual con el disco de Clonezilla y crea una imagen total del volumen (no del disco), en el disco que acabas de instalar.
  Redacta un documento con los pasos que sigues para realizar este ejercicio. Una vez terminado,

7. Restaura la imagen que acabas de creada siguiendo estos pasos:

   - crea una nueva máquina virtual con las mismas características que la anterior
   - conecta el disco duro que contiene la imagen clonada de la máquina CW1001
   - restaura la imagen en la nueva máquina
   - antes de poner la máquina en red, cambia la MAC y la IP de la NIC. También deberás cambiar el nombre del equipo según la nomenclatura del dominio
   - ingresa esa nueva máquina en el dominio

Escribe una guía con los pasos que sigues para realizar esta tarea y súbela al Moodle del módulo una vez finalizada. 8. Crea una imagen ISO del disco de instalación de Microsoft Windows 10 Professional con nLite que contenga las siguientes modificaciones:

- el último service pack integrado
- la última versión de Mozilla Firefox instalada
- la configuración de red sea la establecida para el dominio
- añade el idioma Catalán/Valenciano
- el particionado del disco principal debe ser automático (el disco se dividirá en dos particiones primarias con un volumen cada una C:\ y D:\)
- al finalizar el proceso de instalación deberá meterse en el domino de forma automática
  Redacta un documento con los pasos que sigues para realizar este ejercicio.

9. Crea una imagen ISO de Ubuntu Desktop 24.04 personalizada mediante `cloud-init` con las características descritas en el archivo de configuración user-data de la teoría. Comprueba que funciona e instala el sistema operativo. Lo única configuración que deberías tocar es las de las particiones. Después de la instalación se bloquea. ¿Que está pasando? (revisa el archivo de configuración)
   !!! note
