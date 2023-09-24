# Los permisos básicos

## Permisos y usuarios

El papel de un sistema operativo es también el de asegurar la integridad y el acceso a los datos, lo que es posible gracias a un sistema de permisos. A cada archivo o directorio se le asignan unos privilegios que le son propios, así como autorizaciones de acceso individuales. Al intentar acceder, el sistema comprueba si está autorizado.

Cuando el administrador crea un usuario, le asigna un UID (User Identification) único. Los usuarios
quedan definidos en el archivo `/etc/passwd`. Del mismo modo, cada usuario se integra en, al menos,un grupo (grupo primario). Todos éstos tienen un identificador único, el GID (Group Identification)y están definidos en el archivo `/etc/group`.

El comando `id` permite obtener esta información. A nivel interno, el sistema trabaja únicamente con los UID y GID, y no con los propios nombres.

```bash title="Ejemplo de uso del comando id"
id
uid=1000(julio) gid=1000(julio) grupos=1000(julio),4(adm),20(dialout),24(cdrom),27(sudo),30(dip),46(plugdev),116(lpadmin),118(scanner),126(sambashare),129(vboxusers),998(docker)
```

Se asocian un UID y un GID a cada archivo que define su propietario y su grupo con privilegios. Usted asigna permisos al propietario, al grupo con privilegios y al resto de la gente. Se distinguen tres casos:

- UID del usuario idéntico al UID definido para el archivo. Este usuario es **propietario** del archivo.
- Los UID son diferentes: el sistema comprueba si el GID del usuario es idéntico al GID del archivo. Si es el caso, el usuario **pertenece al grupo** con privilegios del archivo.
- En los otros casos (ninguna correspondencia): se trata del resto de la gente (**others**), ni es el propietario, ni un miembro del grupo con privilegios.

```bash title="Ejemplo de listado de un directorio"
drwxrwxr-x 2 julio julio 4096 sep 22 13:34 cuestionarios

```

En esta línea, el directorio cuestionarios pertenece al usuario julio y al grupo julio, y posee los permisos `rwxrwxr-x`.

### Significado

| Permiso            | Significado                                                                                                                                                                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **General**        |                                                                                                                                                                                                                                                         |
| r                  | Readable (lectura).                                                                                                                                                                                                                                     |
| w                  | Writable (escritura).                                                                                                                                                                                                                                   |
| x                  | Executable (ejecutable como programa).                                                                                                                                                                                                                  |
| **Archivo normal** |
| r                  | Se puede leer el contenido del archivo, cargarlo en memoria, listarlo y copiarlo.                                                                                                                                                                       |
| w                  | Se puede modificar el contenido del archivo. Se puede escribir dentro. Modificar el contenido no significa poder eliminar el archivo (ver permisos en directorio).                                                                                      |
| x                  | Se puede ejecutar el archivo desde la línea de comandos si se trata de un programa binario (compilado) o de un script (shell, perl...).                                                                                                                 |
| **Directorio**     |
| r                  | Se pueden listar (leer) los elementos del directorio (catálogo). Sin esta autorización, ls y los criterios de filtro en el directorio y su contenido no serían posibles. No obstante, puede seguir accediendo a un archivo si conoce su ruta de acceso. |
| w                  | Se pueden modificar los elementos del directorio (catálogo),y es posible crear, volver a nombrar y suprimir archivos en w este directorio.Es este permiso el que controla el permiso de eliminación de un archivo.                                      |
| x                  | Se puede acceder al catálogo por CD y se puede listar. Sin esta autorización, es imposible acceder al directorio y actuar en su contenido, que pasa a estar cerrado.                                                                                    |

## Modificación de los permisos

Existen dos métodos para modificar estos permisos: mediante símbolos o mediante un sistema octal de representación de permisos.

### Mediante símbolos

```bash title="Sinstaxis del comando chmod"
chmod modificaciones file1 [file2...]

```

Para añadir permisos, se utiliza el carácter **+**; para retirarlos, el carácter **-,** y para no tener en cuenta los parámetros anteriores, el carácter **=.**

```bash title="Ejemplo del comando chmod"
-rw-rw-r-- 1 julio julio 0 sep 24 23:41 prueba
chmod u=rwx,g=x,o=rw prueba
-rwx--xrw- 1 julio julio 0 sep 24 23:41 prueba
chmod o-r prueba
-rwx--x-w- 1 julio julio 0 sep 24 23:41 prueba

```

### Mediante sistema binario

La sintaxis es idéntica a la de los símbolos. A cada permiso le corresponde un valor octal, posicional y acumulable. Mediante tres bits.

| propietario | Grupo | Otros |
| ----------- | ----- | ----- | --- | --- | --- | --- | --- | --- |
| r           | w     | x     | r   | w   | x   | r   | w   | x   |

- 0 = = 000
- 1 = –x = 001 (binario)
- 2 = -w- =010
- 3 = -wx =011
- 4 = r- =100
- 5 = r-x=101
- 6 = rw-=110
- 7 = rwx=111

```bash title=""
chmod 777 prueba
-rwxrwxrwx 1 julio julio 0 sep 24 23:41 prueba
```

## Máscara de permisos

### Restringir permisos de manera automática

En el momento de la creación de un archivo o de un directorio, se les asignan unos permisos automáticamente. Suele ser `rw-r--r-- (644)` para un archivo y `rwxr-xr-x (755)` para un directorio. Se puede modificar este comportamiento con el comando `umask`. Según su valor **suprimirá** los permisos que se les den a la hora de crearlos.

La máscara por defecto es 002, o sea -------w-. Para obtener este valor, inserte umask sin parámetro.

```bash title="obtención del valor por defecto de la mascara"
 umask
0002
```

El cálculo de máscara:

- Para un archivo
  Predeterminado rw-rw-rw- (666)
  Retirar ----w--w- (022)
  Resta rw-r--r-- (644)
- Para un directorio
  Predeterminado rwxrwxrwx (777)
  Retirar ----w--w- (022)
  Resta rwxr-xr-x (755)

!!! warning

        una máscara no es sustraer, sino suprimir permisos

## Cambiar de propietario y de grupo

Es posible cambiar el **propietario y el grupo** de un archivo gracias a los comandos chown (change owner) y chgrp (change group). El parámetro -R cambia la propiedad de manera recursiva.

```bash title="sintaxis de los comando chown y chgrp"
chown usuario fic1 [Fic2...]
chgrp grupo fic1 [Fic2...]
```

!!!warning

    Sólo **root** tiene permiso para cambiar el propietario de un archivo. Pero un usuario puede cambiar el grupo de un archivo si forma parte del **nuevo grupo**.
