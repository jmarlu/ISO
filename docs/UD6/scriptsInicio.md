# Scripts de inicio de sesión

A veces es necesario realizar una serie de tareas al inicio de cada sesión. Es posible que algún programa requiera una configuración especial, o es necesario la ejecución de algunos comandos del sistema o incluso programar una tarea antes de que el usuario tome el control del equipo. Todas estas tareas pueden asignarse a un script y ejecutarse al inicio de la sesión. Los scripts, tanto en sistemas operativos Microsoft Windows como GNU/Linux, se analizarán de forma pormenorizada en unidades sucesivas.

Para asignar una secuencia de comandos a un perfil, es necesario crear el script en una carpeta compartida y hacer referencia a él en la configuración de usuario del servidor. Microsoft Windows Server siempre busca las secuencia de comandos de inicio de sesión en la ruta

```bash title
%systemroot%\SYSVOL\sysvol\%userdomain%
```

por lo que será en esta carpeta donde colocaremos los scripts a ejecutar. Las secuencias de comandos de esta carpeta se pueden referenciar sólo a través de su nombre. Si se opta por colocar la secuencias de comando en otra ubicación, habrá que incluir la extensión del fichero también.

En Microsoft Windows Server , desde <span class="menu">Administrador del servidor</span> → <span class="menu">Herramientas</span> → <span class="menu">Usuarios y equipos de Active Directory</span>, se accede a la pestaña de <span class="menu">Perfil</span> en las propiedades del usuario y se especifica el nombre del script de inicio de sesión en el recuadro que tiene el mismo nombre.

![configuración de script de inicio de sesión](img/10000000000005AD000006C065D8DACA6EA83187.jpg)

En sistemas operativos basados en GNU/Linux existen varias formas de configurar esta acción:

- a través de la opción `--script-path=ruta_absoluta` durante la creación o modificación del usuario. Esta opción especifica la ruta en donde el usuario encontrará los scripts de inicio de sesión.
- modificando del fichero `/home/$USER/.bashrc`, el cual contiene los comandos que se ejecutarán al inicio de cada sesión de usuario.
- incluso existe la posibilidad de ejecutar comandos a la salida de la sesión ubicándolos en el fichero `/home/$USER/.bash_logout`.
