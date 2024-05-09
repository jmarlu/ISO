# Actividades

## Introducción

1. Instala cuatro discos duros de 1TB de tamaño, expansión dinámica y del tipo SAS en cada uno de los servidores. Utiliza un nuevo controlador para contener todos los discos. Deberás apagar la máquina virtual para poder hacerlo, pero recuerda que en la realidad este hardware se puede instalar “en caliente”. Describe el proceso que sigues para hacer esta instalación y activar los discos en el sistema operativo en un documento.
2. En el equipo **ServidorWindows**, configura dos grupos de almacenamiento denominado grupo1 (primer y tercer disco instalados) y grupo2 (segundo y cuarto disco instalados). Luego transforma cada uno en un volumen con sistema de archivos NTFS. Asigna las letras X: al primero y K: al segundo. Comprueba que todo funciona de forma adecuada. Escribe un documento con los pasos que sigues para realizar esta configuración

## ACTIVIDADES DE DESARROLLO

1. En el servidor **ServidorUbuntu**, divide los cuatro discos en tres particiones del mismo tamaño (aproximadamente). Con LVM configura tres volúmenes lógicos:
   - el primero con las primeras particiones de los tres primeros discos y con el nombre “Feo1”
   - el segundo con las segundas particiones de los tres primeros discos y con nombre “Feo2”
   - el tercero con las dos primeras particiones del cuarto disco duro y de nombre “Feo3”

Asigna un sistema de ficheros _FAT32_ al primero, _ext4_ al segundo y _ext3_ al tercero. Tras esto, monta esos volúmenes en `/media/Windows` el primero, en `/media/Linux` el segundo y en `/home` el tercero. El proceso de montaje debe ser permanente (modifica el fichero `/etc/fstab`). Documenta todo el proceso junto con los comandos necesarios para realizar estas operaciones.

2. Modifica los volúmenes distribuidos creados en ServidorUbuntu de este modo:

   - añade **la tercera partición** del primer disco a Feo1.
   - añade **la tercera partición del segundo y tercer disco** a Feo2.
   - **elimina** Feo3 y crea un nuevo volumen lógico con las particiones sobrantes con el nombre “Horrible1”.

Redacta un documento que describa los pasos a seguir así como los comandos necesarios.

3. Realiza las configuraciones necesarias para crear un nuevo volumen **RAID 1 en ServidorWindows.** Este RAID debe tener una capacidad de 500 GB y estar montado en la letra L:. Necesitarás varios discos duros virtuales para realizar esta práctica. Instala los que necesites para su realización. Redacta un documento con los pasos que sigues para la configuración.
4. Realiza las configuraciones necesarias para crear un nuevo volumen RAID 1 **en ServidorUbuntu**. Este RAID debe tener una capacidad de 1 TB y estar montado en la carpeta `/media/discoRAID1`. Necesitarás varios discos duros virtuales para realizar esta práctica. Instala los que necesites para su realización. Redacta un documento con los pasos y comandos que sigues para la configuración de cada uno de los RAID.
5. Crea un **nuevo volumen RAID 5 en ServidorWindows**. Este RAID debe tener una capacidad de 1 TB y estar montado en la letra J:. Necesitarás varios discos duros virtuales para realizar esta práctica. Instala los que necesites. Como siempre, escribe una guía con los pasos que sigues para la configuración.
6. Crea un nuevo volumen **RAID 5 en ServidorUbuntu**. Este RAID debe tener una capacidad de 2 TB y estar montado en `/media/discoRAID5`. Necesitarás varios discos duros virtuales para realizar esta práctica. Instala los que necesites. Escribe una guía con los pasos y comandos que sigues para la configuración de cada uno de los RAID.

7. En ServidorWindows instala la característica **“Cifrado de unidad Bitlocker”** a través de Instalar Roles y Características. Tras reiniciar el equipo, cifra el disco del sistema operativo y el de los documentos de los usuarios del dominio (donde se guardan las carpetas personales y los perfiles). Utiliza para ello un cifrado **AES-CBC de 256 bits** para el volumen que contiene el sistema operativo, y un cifrado **AES-CBC de 128 bits** para el resto. Documenta el proceso.

8. En **ServidorUbuntu**, instala la aplicación **eCryptfs** y encripta las carpetas de los usuarios del sistema y de los usuarios del directorio (perfiles, carpetas personales y directorio `/home`). El cifrado debe ser de AES de 128 bits en todos los casos. Documenta el proceso que sigues así como los comandos necesarios para realizar esta instalación.

9. Crea un disco de arranque del sistema de **ServidorWindows**. Este disco se creará de forma manual con las utilidades del sistema y se particionará con la herramienta `diskpart` en modo CLI. Utiliza un dispositivo USB real capturado por la máquina virtual para realizar este ejercicio. Una vez creado comprueba que funciona.

10. Crea un **disco de arranque **en una unidad USB real capturada por la máquina virtual a través de la utilidad dd. El disco de arranque será de la versión Ubuntu Desktop utilizada en los clientes. Comprueba que funciona de forma correcta. Redacta una guía con los pasos que sigues y los comandos necesarios para realizar esta tarea.

## ACTIVIDADES DE AMPLIACIÓN

1.  Realiza las configuraciones necesarias para crear un RAID 10 en cada uno de los servidores. Debe tener una capacidad de 2 TB. Monta este nuevo volumen donde creas oportuno. Ya sabes, redacta un documento con los pasos y comandos que sigues para su instalación.

Necesitarás varios discos duros virtuales más para realizar esta práctica. Llegados a este punto el sistema puede volverse inestable (recuerda que estamos trabajando con sistemas operativos virtualizados). Puedes reutilizar los discos de prácticas anteriores o eliminarlos y colocar los que necesites para la realización de esta práctica.

2. Instala un nuevo disco en ServidorUbuntu de 1 TB de espacio, de tipo SAS y con expansión dinámica. Realiza las siguientes configuraciones con él:
   - Antes de montarlo, instala el sistema de ficheros ZFS. Antes de ello, asegúrate que las _fuentes de software principales, restringidas, universe y multiverse están habilitadas (sudo apt edit-sources )_. Si no es el caso, habilítalas con estos comandos según proceda:
     - `sudo apt-add-repository main`, para las principales
     - `sudo apt-add-repository restricted`, para las restringidas
     - `sudo apt-add-repository universe`, para las universe
     - `sudo apt-add-repository multiverse`, para las multiverse
     - instala con el comando `sudo apt-get install zfsutils-linux`
     - monta esa unidad en `/media/Comprimida`
     - asigna el sistema de ficheros ZFS
     - comprime la unidad con la compresión que estimes oportuna (consulta la ayuda del comando para ello).
