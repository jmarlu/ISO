# Contenedores con LXD/LXC

LXD es un hypervisor para contenedores Linux desarrollado por Canonical Ltd. Es un complemento para los contenedores de Linux (LXC) que facilita su uso y añade nuevas posibilidades.

En la red se puede encontrar mucha información sobre LXD, aquí únicamente se pretende presentar una pequeña introducción a los contenedores en general y a LXD en particular.

## ¿Qué son los contenedores?

Aparentemente en un contenedor se ejecuta un sistema operativo GNU/Linux independiente de otros contenedores y del propio SO anfitrión. Se trata de un producto de la virtualización pero, en lugar de utilizar máquinas virtuales dentro de las cuales se ejecuta un sistema operativo que puede ser diferente del anfitrión, aquí se utilizan técnicas de virtualización a nivel de sistema operativo. De modo que sólo hay un núcleo, en nuestro caso el Linux que se ejecuta en el equipo anfitrión, que mediante diferentes funciones (namespaces, cgroups, ...) muestra vistas parciales a algunos procesos para que crean que se ejecutan en un sistema aislado.

Así que el sistema anfitrión y todos los contenedores utilizan el mismo núcleo. En el sistema anfitrión se pueden ver todos los procesos y en cada uno de los contenedores únicamente los propios. La red, la raíz del sistema de archivos, los ficheros de dispositivo y otros recursos también están virtualizados así que cada contenedor puede tener su propia interfaz de red y sistema de archivos raíz. Incluso es posible que un contenedor utilice una distribución de GNU/Linux diferente del resto pero, eso sí, compartiendo el único núcleo que se ejecuta en el equipo anfitrión.

Las ventaja de los contenedores frente a las máquinas virtuales tradicionales es la eficiencia. Un contenedor es mucho más ligero pues no necesita recrear el hardware de la máquina virtual ni ejecutar dentro otro sistema operativo. Los procesos que se ejecutan en un contenedor al fin y al cabo son procesos nativos del equipo anfitrión. Por lo tanto se consigue un mayor rendimiento y es posible ejecutar en un mismo ordenador un número mucho mayor de contenedores que de máquinas virtuales. Hay artículos en los que se menciona la ejecución de 652 contenedores Ubuntu 14.04LTS en un portátil con 16GB de RAM en el que "solo" es posible ejecutar 31 máquinas KVM sin KSM activado y 65 con KSM activado.

El inconveniente de los contenedores frente a la virtualización completa asistida por hardware es que se apoya en Linux y todos los contenedores deben ejecutar una distribución de GNU/Linux. Pero como usted sabe con una distribución de GNU/Linux es posible hacer mucho.

Otras herramientas similares son:

- **Docker**: El rival directo de LXD/LXC. También es una herramienta de virtualización a nivel de SO nativa de Linux. Pero una de las diferencias respecto a LXD/LXC es que en este caso cada contenedor está orientado a ejecutar únicamente un servicio (Apache, MySQL, ...) en lugar de un SO.
- **Jails de FreeBSD**: La opción nativa de FreeBSD.
- **Solaris Containers**: La opción nativa de Solaris, también presente en sus derivados libres: Illumos, OpenIndiana...

## Instalación en Linux

LXD se puede instalar sobre Ubuntu 14.04 LTS agregando su propio PPA, pero en la versión 16.04 LTS forma parte de los repositorios oficiales y viene acompañado de una gran novedad: ZFS. LXD puede utilizar diferentes storage-backends, por defecto se utiliza un directorio en el sistema de archivos pero combinar los contenedores con alguna herramienta que proporcione COW (como ZFS, Btrfs o LVM) permite mejorar la velocidad y economizar espacio al trabajar con snapshots o al copiar contenedores. Aunque para probar LXD bastará cualquier sistema de archivos.

La instalación en LXD en Ubuntu 14.04 LTS se realiza con los siguientes comandos:

```bash title="Instalación"
add-apt-repository ppa:ubuntu-lxc/lxd-stable
apt-get update
apt-get dist-upgrade
apt-get install lxd
```

La instalación crea el grupo lxd que incluye a los usuarios que pueden utilizarlo. Pero como la información sobre los grupos a los que pertenece un usuario se lee en el momento de iniciar sesión, ahora será necesario salir y volver a entrar. O, alternativamente, ejecutar:

newgrp lxd
En Ubuntu 16.04 LTS no es necesario hacer nada especial para instalar LXD. Únicamente será necesario que el usuario que lo vaya a utilizar forme parte del grupo lxd.

Una vez instalado la gestión de los contenedores se realiza a través de la herramienta lxc. Al ejecutarla sin parámetros se muestran las diferentes opciones:

```bash
usuario@soyuz:~$ lxc
Usage: lxc [subcommand] [options]
Órdenes disponibles
config - Manage configuration.
copy - Copy containers within or in between lxd instances.
delete - Delete containers or container snapshots.
exec - Execute the specified command in a container.
file - Manage files on a container.
help - Presents details on how to use LXD.
image - Manipulate container images.
info - List information on LXD servers and containers.
launch - Launch a container from a particular image.
list - Lists the available resources.
move - Move containers within or in between lxd instances.
profile - Manage configuration profiles.
publish - Publish containers as images.
remote - Manage remote LXD servers.
restart - Changes state of one or more containers to restart.
restore - Set the current state of a resource back to a snapshot.
snapshot - Create a read-only snapshot of a container.
start - Changes state of one or more containers to start.
stop - Changes state of one or more containers to stop.
version - Prints the version number of this client tool.

Opciones:
--all Print less common commands.
--debug Print debug information.
--verbose Print verbose information.

Entorno:
LXD_CONF Path to an alternate client configuration directory.
LXD_DIR Path to an alternate server directory.
usuario@soyuz:~$
```

Contenedores, imágenes y remotos
Los contenedores se lanzan a partir de imágenes y las imágenes se almacenan en repositorios locales o remotos. LXD facilita la gestión de contenedores, imágenes y remotos (repositorios de imágenes). De hecho, gracias a que la mayoría de operaciones son automáticas es posible lanzar un contenedor desde el primer momento (lo que descargará de manera automática la imagen necesaria).

Pero vamos a verlo con más detalle. La primera vez que se ejecuta LXD es posible utilizar el comando lxc image list para comprobar que esta máquina todavía no tiene ninguna imagen:

usuario@soyuz:~$ lxc image list
Generating a client certificate. This may take a minute...
If this is your first time using LXD, you should also run: sudo lxd init
To start your first container, try: lxc launch ubuntu:16.04

+-------+-------------+--------+--------------+-----+---------+-------------+
| ALIAS | FINGERPRINT | PUBLIC | DESCRIPCIÓN | ARQ | TAMAÑO | UPLOAD DATE |
+-------+-------------+--------+--------------+-----+---------+-------------+
usuario@soyuz:~$
Y obtener dos informaciones:

Que se puede utilizar sudo lxd init para configurar diferentes aspectos de LXD como la red o el backend de almacenamiento. Aunque las opciones por defecto son razonables y no es necesario cambiarlas.
Que se puede lanzar un nuevo contenedor mediante el comando: lxc launch ubuntu:16.04

Lanzar un nuevo contenedor es tan sencillo como ejecutar el comando indicado, en cuyo caso nos lanzará un nuevo contenedor con un nombre generado dinámicamente, o bien especificar el nombre del contenedor (u1 en este ejemplo) al ejecutar: lxc launch ubuntu:16.04 u1. Al ser la primera vez que se utiliza la imagen ubuntu:16.04 primero se descargará de forma automática, se guardará en el repositorio local y después se lanzará el contenedor u1.

usuario@soyuz:~$ lxc launch ubuntu:16.04 u1
Creando u1
Retrieving image: 100%
Iniciando u1
usuario@soyuz:~$
Podemos ver el estado del nuevo contenedor al ejecutar: lxc list

usuario@soyuz:~$ lxc list
+--------+---------+------+------+------------+-----------+
| NOMBRE | ESTADO | IPV4 | IPV6 | TIPO | SNAPSHOTS |
+--------+---------+------+------+------------+-----------+
| u1 | RUNNING | | | PERSISTENT | 0 |
+--------+---------+------+------+------------+-----------+
usuario@soyuz:~$
Y comprobar que ahora sí contamos con una imagen descargada: lxc image list

usuario@soyuz:~$ lxc image list
+-------+--------------+--------+---------------------------------------------+--------+----------+------------------------------+
| ALIAS | FINGERPRINT | PUBLIC | DESCRIPCIÓN | ARQ | TAMAÑO | UPLOAD DATE |
+-------+--------------+--------+---------------------------------------------+--------+----------+------------------------------+
| | f452cda3bccb | no | ubuntu 16.04 LTS amd64 (release) (20160627) | x86_64 | 310.30MB | Jul 14, 2016 at 8:29am (UTC) |
+-------+--------------+--------+---------------------------------------------+--------+----------+------------------------------+
usuario@soyuz:~$
A partir de una imagen se pueden lanzar diferentes contenedores. Y naturalmente es posible tener diferentes imágenes que sirvan como base para lanzar contenedores (unos con OpenSSH instalado, otros con la pila LAMP) o imágenes de diferentes distribuciones de GNU/Linux (Ubuntu, CentOS, Fedora...).

Las imágenes se pueden importar/exportar desde/a un fichero tarball y a partir de un contenedor es posible publicar una imagen.

Utilizando contenedores
Las operaciones básicas con los contenedores son:

Función: Comando:
Listar contenedores lxc list
Lanzar un contenedor nuevo lxc launch <imagen> [nombre]
Detener un contenedor lxc stop <nombre>
Encender un contenedor lxc start <nombre>
Obtener un shell en un contenedor lxc exec <nombre> -- /bin/bash
Borrar un contenedor o snapshot lxc delete <nombre>

Es posible utilizar el comando lxc launch para lanzar un nuevo contenedor a partir de una imagen (por ejemplo: lxc launch ubuntu:16.04 u1). Una vez creado el contenedor estará en ejecución y se podrá detener o volver a encender respectivamente con los comandos lxc stop y lxc start. Cuando el contenedor ya no sea necesario se puede borrar con lxc delete.

También es posible abrir un terminal en un contenedor para ejecutar comandos de manera interactiva: lxc exec u1 -- /bin/bash

Un pequeño ejemplo de uso:

usuario@soyuz:~$ lxc list
+--------+---------+------+------+------------+-----------+
| NOMBRE | ESTADO | IPV4 | IPV6 | TIPO | SNAPSHOTS |
+--------+---------+------+------+------------+-----------+
| u1 | RUNNING | | | PERSISTENT | 0 |
+--------+---------+------+------+------------+-----------+
usuario@soyuz:~$ lxc exec u1 -- /bin/bash
root@u1:~# uname -a
Linux u1 4.4.0-28-generic #47-Ubuntu SMP Fri Jun 24 10:09:13 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
root@u1:~# exit
exit
usuario@soyuz:~$ lxc stop u1
usuario@soyuz:~$ lxc list
+--------+---------+------+------+------------+-----------+
| NOMBRE | ESTADO | IPV4 | IPV6 | TIPO | SNAPSHOTS |
+--------+---------+------+------+------------+-----------+
| u1 | STOPPED | | | PERSISTENT | 0 |
+--------+---------+------+------+------------+-----------+
usuario@soyuz:~$ lxc delete u1
usuario@soyuz:~$ lxc list
+--------+--------+------+------+------+-----------+
| NOMBRE | ESTADO | IPV4 | IPV6 | TIPO | SNAPSHOTS |
+--------+--------+------+------+------+-----------+
usuario@soyuz:~$
Con los contenedores además de las operaciones mostradas es posible:

Crear instantáneas (snapshots) y restaurar su estado incluyendo su memoria.
Copiar y/o mover contenedores entre diferentes servidores LXD.
Copiar ficheros de y hacia el contenedor.
Publicar una imagen a partir de un contenedor y, si se desea, obtener el tarball que la representa.

Sobre la configuración por defecto de la red en los contenedores
La configuración de red por defecto para los contenedores está definida en el fichero /etc/default/lxd-bridge.

Básicamente allí se especifica:

Que en el anfitrión se declara un puente: lxdbr0 (recuerde que los puentes se pueden inspeccionar/gestionar con brctl)
Que se modificará el perfil por defecto de los contenedores para que hagan uso del puente.
Por defecto están vacíos, pero hay campos para especificar la IP del puente y el rango de concesiones DHCP a utilizar para los contenedores.
La configuración de los equipos del aula utiliza el fichero /etc/network/interfaces para incluír la interfaz de red física como un puerto del puente, de tal manera que los contenedores puedan acceder a la LAN del aula tal y como lo hacen las estaciones físicas.

¿Es posible limitar los recursos de un contenedor?
Por supesto, de hecho resulta muy recomendable limitar y priorizar los recursos de los contenedores. Si no se imponen límites por defecto los contenedores comparten los recursos de la maquina anfitrión: CPU, memoria principal, espacio swap, interfaces de red y disco.

Pero es posible utilizar los cgroups para limitar los recursos o especificar prioridades en su asignación. LXD permite manejar la configuración de un contenedor de forma individual o bien crear un perfíl que luego se puede aplicar a varios contenedores.

Veamos qué configuración tiene un contenedor recién creado:

usuario@soyuz:~$ lxc launch ubuntu:16.04 u1
Creando u1
Iniciando u1
usuario@soyuz:~$ lxc config show u1
name: u1
profiles:

- default
  config:
  volatile.base_image: f452cda3bccb2903e56d53e402b9d35334b4276783d098a879be5d74b04e62e2
  volatile.eth0.hwaddr: 00:16:3e:74:be:3a
  volatile.last_state.idmap: '[{"Isuid":true,"Isgid":false,"Hostid":100000,"Nsid":0,"Maprange":65536},{"Isuid":false,"Isgid":true,"Hostid":100000,"Nsid":0,"Maprange":65536}]'
  devices:
  root:
  path: /
  type: disk
  ephemeral: false
  usuario@soyuz:~$
  Y como es posible fijar un límite para el consumo de memoria principal:

usuario@soyuz:~$ lxc config set u1 limits.memory 512MB
usuario@soyuz:~$ lxc config show u1
name: u1
profiles:

- default
  config:
  limits.memory: 512MB
  volatile.base_image: f452cda3bccb2903e56d53e402b9d35334b4276783d098a879be5d74b04e62e2
  volatile.eth0.hwaddr: 00:16:3e:74:be:3a
  volatile.last_state.idmap: '[{"Isuid":true,"Isgid":false,"Hostid":100000,"Nsid":0,"Maprange":65536},{"Isuid":false,"Isgid":true,"Hostid":100000,"Nsid":0,"Maprange":65536}]'
  devices:
  root:
  path: /
  type: disk
  ephemeral: false
  usuario@soyuz:~$
  Y el cambio es visible desde el punto de vista del contenedor:

usuario@soyuz:~$ lxc exec u1 -- /bin/bash
root@u1:~# free -m
total used free shared buff/cache available
Mem: 512 11 421 8 79 421
Swap: 1021 2 1019
root@u1:~#
La propia documentación de LXD muestra qué configuraciones y límites se pueden definir.

Algunos de los parámetros básicos son:

Key Type Default Description
boot.autostart boolean false Si está activo indica que se debe arrancar el contenedor cuando arranque LXD.
limits.cpu string all Número o rango de CPUs para el contenedor.
limits.cpu.allowance string 100% Cuota de CPU a utilizar por el contendor. Si se utiliza un % se trata de un límite blando, si se utiliza algo como "25ms/100ms" se trata de un límite duro.
limits.memory string all Límite de memoria para el contendor. Es posible utilizar los sufijos: kB, MB, GB, TB, PB, EB.
Cómo añadir discos o interfaces de red:
La configuración por defecto de un contenedor ya incluye un disco con el sistema raíz y una interfaz de red. Pero es posible añadir nuevas interfaces de red o discos. Estos dispositivos se pueden añadir:

De manera particular a un contenedor
De manera general a un perfil que utilizarán varios contenedores
Discos:

Los discos son básicamente directorios o dispositivos de bloques en el sistema anfitrión que se montan en el lugar indicado del contenedor.

En el siguiente ejemplo se lanza el contenedor u1, se crea el directorio directorio1 en el sistema anfitrión, y se añade como un nuevo disco disponible en /mnt/disco1 en el contenedor.

usuario@soyuz:~$ lxc launch ubuntu:16.04 u1
Creando u1
Iniciando u1
usuario@soyuz:~$ mkdir disco1
usuario@soyuz:~$ lxc config device add u1 disco1 disk source=/home/usuario/disco1 path=/mnt/disco1
Device disco1 added to u1
usuario@soyuz:~$ lxc exec u1 -- /bin/bash
root@u1:~# cd /mnt/
root@u1:/mnt# ll
total 6
drwxr-xr-x 3 root root 3 Jul 27 08:24 ./
drwxr-xr-x 22 root root 22 Jul 27 07:20 ../
drwxrwxr-x 2 nobody nogroup 4096 Jul 27 08:22 disco1/
root@u1:/mnt#
Interfaces de red:

Es posible añadir diferentes tipos de interfaces de red. Por ejemplo: physical (una interfaz física del anfitrión que se dedica en exclusiva a un contenedor) o bridged (una interfaz del contenedor que estará asociada a una interfaz en el equipo físico que formará parte del puente indicado).

En el siguiente ejemplo se muestra cómo añadir una nueva interfaz de red en modo puente (eth1) utilizando el puente lxdbr0 de la máquina física.

usuario@soyuz:~$ lxc launch ubuntu:16.04 u1
Creando u1
Iniciando u1
usuario@soyuz:~$ lxc config device add u1 eth1 nic nictype=bridged parent=lxdbr0
Device eth1 added to u1
usuario@soyuz:~$ lxc exec u1 -- /bin/bash
root@ubuntu:~# ifconfig eth1
eth1 Link encap:Ethernet HWaddr 00:16:3e:61:45:e8  
 BROADCAST MULTICAST MTU:1500 Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000
RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)

root@ubuntu:~#
