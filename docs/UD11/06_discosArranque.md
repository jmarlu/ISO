# Discos de arranque y de recuperación.

Un disco de arranque o disco de inicio es un tipo de medio extraíble, como un disquete, un CD, DVD o unidad USB, que contiene los archivos de inicio del sistema operativo. Con él se puede iniciar el equipo cuando existe un error de hardware o de software que impide el inicio normal del sistema.
Generalmente el método más utilizado para instalar un sistema operativo en un ordenador, como ya se ha estudiado en temas anteriores, es a través de un DVD. Sin embargo, algunos ordenadores no vienen por defecto con hardware lector de discos, especialmente los portátiles. Actualmente existen alternativas más rápidas, cómodas y eficaces como los dispositivos de memoria extraíbles USB.
Existen varias aplicaciones para crear discos de arranque y recuperación tanto para Microsoft Windows como GNU/Linux. La idea es crear un dispositivo de instalación en una de estas unidades a través de la cual sea posible tanto reparar el sistema operativo dañado, como iniciarlo desde uno de estos dispositivos.
Ya se han visto varios métodos de creación de estos discos como RUFUS o Microsoft USB/DVD Download Tool, aunque también es posible crear uno de estos dispositivos de forma manual.

## Creación de un dispositivo USB de instalación de Windows

Estos programas anteriores se centran en automatizar un proceso que también podemos realizar a través de las opciones del sistema operativo. Dicho proceso se basa en preparar la memoria USB para que los sistemas sean capaces de arrancar desde ella y, una vez configurada, copiar los archivos necesarios para la instalación.

En sistemas operativos de Microsoft, se accede a la herramienta a través de <span class="menu">Inicio</span> → <span class="menu">Herramientas administrativas de Windows</span> → <span class="menu">Unidad de recuperación </span> aparecerá un asistente que guiará el proceso.

Para crear un disco de arranque de forma manual simplemente hay que dar dos pasos.

- Crear una partición primaria activa en el dispositivo y asignarle el sistema de archivos FAT32. Es posible realizar este proceso en modo gráfico, pero se revisará cómo hacerlo desde el terminal de Microsoft a través de la utilidad `diskpart`.
- Se abre una ventana de terminal con permisos de administración y se ejecuta el comando `diskpart`, el cual abrirá una nueva ventana con su propio prompt.

Para ver una lista de todos los dispositivos conectados e identificar el dispositivo USB

```bash title=""

list disk
```

Después se elige la unidad con la que va a trabajar, representada por el número del dispositivo del listado

```bash title=""
select disk 2
```

Para asegurar que la unidad seleccionada es la adecuada, se usa de nuevo el comando list disk y debe aparecer un asterisco antes del nombre del disco seleccionado. Tras esta comprobación, y antes de crear ninguna partición, se borran las particiones existentes en la unidad

```bash title=""
clean
```

Una vez limpia, se crea una partición primaria
create partition primary. Y queda la asignación del sistema de ficheros.

```bash title=""
format fs=fat32 quick
```

El proceso no debería llevar mucho tiempo y una vez finalice ya se dispone de una memoria lista para arrancar el equipo.

Ahora será necesario el segundo paso que es sencillo: copiar los ficheros de un disco de instalación en la unidad preparada. Una vez terminado, se dispone de un dispositivo de inicio con el que poder arrancar cualquier equipo.

Para crear un disco de arranque en GNU/Linux también existen aplicaciones con GUI, aunque la explicación se centrará en el uso de `dd` a través de CLI.

Los pasos a seguir son los mismo que en el caso anterior: prepara la unidad USB y copiar los ficheros necesarios. Tras insertar la unidad de USB en el sistema, se busca que fichero de dispositivo está asociado a ella con el comando

```bash title=""
sudo fdisk -l
```

Se detecta que la unidad de USB está situada en
`/dev/sdf` y que tiene una única partición en `/dev/sdf1`. Si la unidad ha sido montada de forma automática, algunas distribuciones lo hacen, será necesario desmontarla. Primero se comprueba si existe montaje

```bash title=""
mount | grep /dev/sdf
```

Si devuelve alguna línea la unidad está montada, por lo que hay que proceder a desmontarla

```bash title=""
sudo umount /dev/sdf
```

Por último, tan sólo queda copiar los ficheros de instalación en el disco. Además, dará el formato adecuado al dispositivo

```bash title=""
sudo dd if=ubuntu-18.10-desktop-amd64.iso of=/dev/sdf bs=4M
```

En donde, if representa el origen de datos, `of` el destino y `bs=4M` es una opción para acelerar el proceso de creación del disco de arranque. Al finalizar el proceso, se dispondrá de un dispositivo de inicio con el que poder iniciar desde cualquier equipo.
