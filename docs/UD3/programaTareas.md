# Programación de tareas

En cualquier sistema operativo existen tareas recurrentes que conviene automatizar para liberar al equipo de administración. Copias de seguridad, limpieza de temporales o la recopilación de informes son ejemplos típicos. Para facilitar este trabajo, cada plataforma ofrece herramientas capaces de programar dichas tareas y delegar su ejecución en el propio sistema.

En Microsoft Windows Server la herramienta principal es el **Programador de tareas**. Se accede desde <span class="menu">Administrador del servidor</span> → <span class="menu">Herramientas</span> → <span class="menu">Programador de tareas</span>. Desde el menú <span class="menu">Acción</span> es posible crear nuevas tareas mediante la opción <span class="menu">Crear tarea básica…</span> (asistente guiado) o <span class="menu">Crear tarea…</span> (configuración avanzada). La ventana de configuración se organiza en cinco pestañas:

- <span class="menu">General</span>: permite asignar nombre y descripción, elegir la cuenta con la que se ejecutará la tarea y definir el contexto de seguridad. Es recomendable marcar **Ejecutar tanto si el usuario inició sesión como si no** para que la tarea no dependa de una sesión interactiva.
- <span class="menu">Desencadenadores</span>: determina qué eventos activan la tarea (programación, inicio de sesión, registro de un evento, conexión de un usuario específico, etc.). Las opciones disponibles dependen del tipo de desencadenador elegido.
- <span class="menu">Acciones</span>: especifica qué se hará cuando se dispare el desencadenador. Lo habitual es ejecutar un script o un programa, pero se puede abrir cualquier aplicación. El proceso heredará los permisos de la cuenta indicada en la pestaña General, por lo que conviene extremar las precauciones.
- <span class="menu">Condiciones</span>: define requisitos extra para que la tarea se inicie, como que el equipo esté en corriente alterna, que exista conectividad de red o que el equipo esté inactivo.
- <span class="menu">Configuración</span>: añade parámetros de control adicionales (reintentos, detención tras un tiempo máximo, manipulación de tareas en ejecución, etc.).

Además de crear tareas, el programador permite revisar qué tareas están activas desde <span class="menu">Acción</span> → <span class="menu">Mostrar todas las tareas en ejecución</span>, lo que resulta útil para diagnosticar ejecuciones prolongadas o bloqueos.

En los sistemas operativos basados en **GNU/Linux** la programación periódica recae en el demonio `cron`, que cada minuto revisa si debe lanzar alguna tarea. A diferencia del Programador de tareas de Windows, `cron` no ofrece interfaz gráfica: las tareas se definen mediante comandos o scripts de consola.

### Directorios gestionados automáticamente

Muchas distribuciones proporcionan directorios especiales que `cron` recorre con la utilidad `run-parts`. Cualquier script ejecutable que se coloque en ellos se lanzará con la periodicidad indicada:

- `/etc/cron.hourly`
- `/etc/cron.daily`
- `/etc/cron.weekly`
- `/etc/cron.monthly`

Algunos sistemas añaden `/etc/cron.d/` para agrupar archivos con el mismo formato que `/etc/crontab`. Este enfoque facilita instalar paquetes que introducen sus propias tareas programadas sin modificar el fichero principal.

### Archivo `/etc/crontab` y sintaxis

El fichero `/etc/crontab` controla la planificación global. Un ejemplo típico es:

```bash title="Fichero de configuración de cron"
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m  h  dom mon dow usuario  comando
17  *  *   *   *  root      run-parts /etc/cron.hourly
25  6  *   *   *  root      run-parts /etc/cron.daily
47  6  *   *   7  root      run-parts /etc/cron.weekly
52  6  1   *   *  root      run-parts /etc/cron.monthly
```

Las dos primeras líneas definen variables de entorno:

- `SHELL` indica el intérprete usado para ejecutar los comandos. Si no se declara, se emplea el definido para el usuario que lanza la tarea.
- `PATH` establece los directorios donde se buscarán los ejecutables. Puede diferir del `PATH` interactivo del usuario.

Cada línea posterior describe una tarea. Se compone de cinco campos de tiempo, el usuario que ejecutará la orden y el comando propiamente dicho:

| Campo       | Descripción                                                                                                                                                                                                            |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Minuto      | Valor entre 0 y 59. Indica el minuto exacto en el que se inicia la tarea.                                                                                                                                              |
| Hora        | Valor entre 0 y 23. Usa formato de 24 horas (0 corresponde a medianoche).                                                                                                                                              |
| Día del mes | Valor entre 1 y 31. Determina el día del mes en el que se ejecuta la tarea.                                                                                                                                            |
| Mes         | Valor entre 1 y 12 o abreviatura en inglés (`jan`, `feb`, `mar`, ...).                                                                                                                                                 |
| Día de la semana | Valor entre 0 y 7 (0 y 7 representan el domingo) o abreviatura en inglés (`mon`, `tue`, `wed`, ...).                                                                                                              |
| Usuario     | Cuenta con la que se ejecutará el comando (solo en `/etc/crontab` y en los ficheros de `/etc/cron.d`).                                                                                                                 |
| Comando     | Orden o script a ejecutar. Puede incluir tuberías, redirecciones y rutas absolutas.                                                                                                                                    |

El carácter `*` significa “cualquier valor” en ese campo. Para aclarar la lectura, a continuación se muestran algunas combinaciones frecuentes (separadas por espacios para resaltar los siete campos):

```bash title="Ejemplos de ejecuciones programadas"
1   *   *   *   *   root  /usr/local/bin/rotar_logs.sh           # Minuto 1 de cada hora
15  8   *   *   *   root  /usr/local/bin/backup.sh               # Cada día a las 08:15
0   17  *   *   0   root  /usr/local/bin/revision_semana.sh      # Domingos a las 17:00
*/5 5-7 *   *   1-5 root  /usr/local/bin/reporte_red.sh          # Cada 5 min entre las 05:00 y las 07:59 de lunes a viernes
30  9   20  7   *   root  /usr/local/bin/felicitacion.sh         # 20 de julio a las 09:30, sin importar el día de la semana
0   12  1   */2  *   root  /usr/local/bin/auditoria.sh          # Día 1 de cada mes par al mediodía
```

### Listas, rangos e incrementos

Los campos de tiempo admiten varias sintaxis combinables:

- **Listas** separadas por comas: `0,15,30,45` ejecuta a los minutos 0, 15, 30 y 45.
- **Rangos** con guiones: `1-5` equivale de lunes a viernes en el campo “día de la semana”.
- **Incrementos** con la barra `/`: `*/10` significa “cada diez unidades del campo”.

```bash title="Ejemplos con listas y saltos"
59 11  *   jan-mar mon-fri  root  /usr/local/bin/cierre_trimestral.sh
45 *   10-25 *     sat,sun   root  /usr/local/bin/respaldo_fechas.sh
*/15 10-14 *  *     *        root  /usr/local/bin/informe_mediodia.sh
0  12  1-10/2 feb,aug *      root  /usr/local/bin/auditoria_extra.sh
```

Todos los criterios se evalúan con un **AND**: la tarea solo se ejecuta cuando se cumplen simultáneamente las cinco condiciones temporales.

### Gestionar cron por usuario con `crontab`

`cron` es multiusuario. Además del fichero global, cada cuenta puede mantener su propio listado con `crontab`. Los archivos individuales se almacenan (según la distribución) en `/var/spool/cron/crontabs/usuario`.

Comandos básicos:

- `crontab -e`: abre el editor de texto configurado (por defecto `vi`) para modificar la tabla del usuario actual.
- `crontab -l`: muestra la programación vigente.
- `crontab -r`: elimina la programación del usuario (conviene usarlo con precaución).

Los ficheros de usuario omiten el campo “usuario”, por lo que solo incluyen los cinco campos de tiempo y el comando. Si se definen tareas personales, el demonio `cron` leerá tanto la tabla del sistema como la del usuario, además de cualquier archivo en `/etc/cron.d/`. Los archivos `/etc/cron.allow` y `/etc/cron.deny`, cuando existen, permiten restringir quién puede usar `crontab`.

## Systemd timers

`systemd` ofrece una alternativa moderna a `cron` mediante unidades de tipo **timer**. Permiten reutilizar toda la infraestructura de dependencias y registros de `systemd`, además de soportar expresiones de calendario más legibles (`OnCalendar=`, `OnActiveSec=`, etc.).

### Ejemplo: registrar la fecha cada 10 minutos

Con `cron` bastaría con crear una entrada como la siguiente, que añadirá la fecha al archivo `/tmp/date` cada diez minutos:

```bash title="Ejemplo con crontab"
*/10 * * * * /usr/bin/date >> /tmp/date
```

La versión con `systemd` separa la lógica en dos archivos: una unidad de servicio que realiza la acción y una unidad de temporizador que define la frecuencia.

1. Crear el servicio `/etc/systemd/system/date.service`:

   ```bash title="Contenido de date.service"
   [Unit]
   Description=Guardar la fecha actual en /tmp/date

   [Service]
   Type=oneshot
   ExecStart=/usr/bin/env sh -c '/usr/bin/date >> /tmp/date'
   ```

2. Crear el temporizador `/etc/systemd/system/date.timer`:

   ```bash title="Contenido de date.timer"
   [Unit]
   Description=Ejecuta date.service cada 10 minutos

   [Timer]
   OnCalendar=*:0/10
   AccuracySec=1min

   [Install]
   WantedBy=timers.target
   ```

3. Recargar la configuración y habilitar el temporizador para que se inicie automáticamente:

   ```bash title="Activar y comprobar el temporizador"
   sudo systemctl daemon-reload
   sudo systemctl enable --now date.timer
   systemctl list-timers --all | grep date
   journalctl -u date.service --since "1 hour ago"
   ```

La salida de `systemctl list-timers` muestra los temporizadores activos con su última y próxima ejecución, lo que facilita la comprobación de la planificación. Si se desea desactivar la tarea se puede ejecutar `sudo systemctl disable --now date.timer`.
