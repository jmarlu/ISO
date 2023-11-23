# Actividades de la UD7

## Actividad 1

1. Es hora de retomar la estructura de la empresa que creaste con anterioridad. Planifica por escrito o mediante un gráfico, la creación de grupos y unidades organizativas para la correcta gestión de tu empresa. Utiliza las estrategias de anidamiento vistas en clase. Puedes seguir estas pautas para ayudarte en tu planificación:

- es conveniente que cada departamento o área específica disponga de un grupo y una unidad organizativa
- ten en cuenta la creación de grupos transversales como responsables o encargados
- suele ser muy útil la creación de grupos funcionales (según la actividad o escalafón en la empresa) además de los anteriores
- en la medida de lo posible, trata de evitar usar grupos incorporados (built-in) en esta planificación

## Actividad 2

1.  Crea los grupos nacidos de tu organización en ServidorWindows a través de GUI e introduce a los usuarios que correspondan en cada grupo. Deberás crear una breve descripción de las funciones de este grupo. Documenta el proceso y crea un documento con los pasos que sigues.
2.  Crea los grupos ServidorUbuntu a través de CLI e introduce a los usuarios que correspondan en cada grupo, del mismo modo que lo has realizado en ServidorWindows. También deberás especificar sus funciones en su descripción. Documenta el proceso, incluyendo los comandos que usas, y crea un documento con los pasos que sigues.
3.  Turno para las unidades organizativas. Crea las unidades organizativas necesarias en ServidorWindows a través de CLI e introduce a los grupos y/o usuarios necesarios según tu planificación.
4.  A través de **RSAT** de uno de los clientes del dominio gobernado por ServidorUbuntu, crea las unidades organizativas necesarias y distribuye los objetos de forma adecuada para el correcto funcionamiento de tu empresa.
5.  Desinstala el navegador web instalado con anterioridad en el cliente **CW1001** desde **ServidorWindows** utilizando para ello la Cuenta de Equipo de este cliente.
6.  En **ServidorWindows**, a través de la utilidad de Administración de políticas de grupo modifica las siguientes directivas de **Default Domain Policy** y comprueba que los cambios introducidos surten efecto.

          - **habilita Active Desktop**, esto nos permitirá realizar cambios en el escritorio de los usuarios
          - Como **papel tapiz** de todos los usuarios descarga y configura este (http://tuxlink.files.wordpress.com/2007/10/leopard-server-wallpaper.jpg). La posición debe ser Centrada
          - quita el menú ayuda del menú de Inicio
          - los usuarios no deben cambiar ninguno de las configuraciones de escritorio. Esta norma afectará a varias directivas situadas, eso sí, en el mismo contenedor

Para comprobar algunas cambios deberás usar el comando `gpupdate /force` en el cliente.

7. Crea una nueva política de grupo que afecte a todos los objetos del dominio controlados por ServidorWindows denominada **“Normas Empresa”**. Esta nueva política tendrá las siguientes configuraciones:

   - los usuarios del dominio no podrán acceder a las **herramientas para cambiar el registro**. Cuando se inicie la sesión de un usuario del dominio, será necesario el inicio de los programas **bloc de notas (notepad.exe)** y Explorador de Windows (explorer.exe). Ambos se encuentran ubicados en el directorio **C:\Windows**
   - **deshabilita el protector de pantalla** y como medida de seguridad adicional, que la pestaña de Protector de Pantalla no sea visible
   - limitar el **idioma** de los usuarios a Español evitando que se puedan agregar nuevos
   - no queremos que los usuarios agregan ninguna **impresora**. Tampoco queremos que eliminen ninguna impresora
   - no queremos que los usuarios puedan Agregar o quitar ningún **programa**
   - queremos deshabilitar cualquier acceso a la **configuración de red** para evitar que puedan cambiar ni ver ninguna configuración
   - impediremos que los equipos busquen **actualizaciones automáticas** durante las sesiones de los usuarios del dominio

Recuerda que puedes comprobar los cambios con el comando `gpupdate /force` en el cliente.

8. En todos los equipos de la empresa debe existir una alternativa de navegador. Realiza las configuraciones necesarias en ServidorWindows para instalar el **navegador Mozilla Firefox** en todos los equipos al inicio de la próxima sesión.
9. Es muy común que los usuarios dejen su **sesión abierta** mientras se ausentan de su puesto de trabajo, esto permitiría que un usuario malintencionado acceda a información o a aplicaciones sin autorización. Configura una directiva para que se bloquee la sesión pasados **cinco minutos** y sea necesario volver a introducir la contraseña de usuario para reiniciar la sesión. Serán necesarias la activación de **tres directivas** para realizar esta tarea.
10. Como has observado, la configuración de las políticas de grupo es un trabajo arduo. Realiza una copia de seguridad de las políticas de seguridad copiando los archivos que la conforman a un lugar seguro. Utiliza un comando para ello y programa esta copia. Realiza esta configuración tanto en **ServidorWindows** como en **ServidorUbuntu**.

## Actividad 3. REFUERZO

1.  Crea un grupo denominado Ayudantes Administradores e introduce a dos usuarios del departamento TIC en él. Para hacer esto sigue los siguientes pasos:
    1.  accede a <span class="menu">Herramientas</span> → <span class="menu">Usuarios y equipos de Active Directory</span>, botón derecho <span class="menu">Nuevo</span> → <span class="menu">Grupo</span> y crea el nuevo grupo con ámbito Dominio local y tipo Seguridad. ¿Qué significan estas características?. ¿Es buena idea hacer un grupo Universal?. ¿Por qué?
    2.  introduce a dos usuarios del departamento TIC. Prueba a abrir sesión con uno de ellos en ServidorWindows. ¿Qué ocurre?. Vuelve a iniciar sesión con el usuario Administrador
    3.  incluye a ese usuario en el grupo Administradores e intenta ahora iniciar sesión en ServidorWindows. ¿Qué ocurre?. Vuelve a iniciar sesión con el usuario Administrador. ¿Es buena idea incluir a usuarios en este grupo?
    4.  accede a la carpeta Builtin. ¿Has creado tú estos grupos?, ¿para qué sirven?. Describe alguno de los grupos que existen a modo de ejemplo
2.  Vamos a crear una política específica para el servidor Servidor Windows. Para ello sigue los siguientes pasos:
    1.  Accede a <span class="menu">Herramientas</span> → <span class="menu">Administración de directivas de grupo</span> y crea una nueva política con el nombre **Política Departamento TIC (botón derecho sobre el nombre del dominio)**. ¿Para qué se usan las cinco pestañas que aparecen si pulsamos en la política que acabamos de crear? Explica cada una de ellas (Ámbito, Detalles, Configuración, Delegación y Estado).
    2.  Edita la GPO recién creada y accede a Configuración de <span class="menu">Usuario</span> → <span class="menu">Preferencias</span> → <span class="menu">Configuración de Panel de control</span> → <span class="menu">Opciones de carpeta</span>. Pulsamos botón derecho sobre ella → <span class="menu">Nuevo</span> y nos permitirá crear configuraciones estándar para cada equipo. Elige Opciones de carpeta (como mínimo, Windows Vista) y selecciona la opción Mostrar archivos y carpetas ocultos. ¿Qué efecto tendrá esto en los usuario?. Comprueba que funciona.
    3.  Cierra el editor de políticas de grupo. Ahora accede a la pestaña detalles y en Estado de GPO selecciona Configuración de Usuario Deshabilitada. ¿Qué efectos tendrá esta configuración en la GPO?. ¿Cómo podemos forzar la actualización de una Política de grupo recién creada?.

## Actividad 4. AMPLIACIÓN

1.  Crea dos grupos locales de dominio en **ServidorWindows** que dispondrán de los siguientes privilegios:

    1.  grupo denominado “**Ayudante TIC**” con los siguientes privilegios:

        - Agregar estaciones al dominio
        - Cambiar la hora del sistema
        - Cambiar la zona horaria
        - Cargar y descargar controladores de dispositivo
        - Tener acceso a este equipo desde la red

    2.  grupo denominado “Gestor de datos” con los siguientes privilegios:

        - Crear objetos compartido permanentes
        - Hacer copias de seguridad de archivos y directorios
        - Permitir inicio de sesión local
        - Realizar tareas de mantenimiento del volumen
        - Restaurar archivos y directorios
        - Tomar posesión de archivos y otros objetos

Crea dos usuarios en tu empresa pertenecientes al departamento TIC y asígnales uno de estos grupos. Comprueba que el nuevo usuario puede realizar las tareas descritas.

2. Instala en **CW1001** un nuevo disco duro SATA con 100 GB de capacidad y expansión dinámica. Arranca el equipo sin iniciar sesión. Desde **ServidorWindows** y con un usuario perteneciente al grupo **Gestor de datos**, configura el nuevo disco duro como un volumen dinámico que contendrá los documentos personales de los usuarios de ese equipo _(recuerda que los documentos personales se encuentran en C:\Usuarios)_.
3. Retoma el esquema de tu empresa y diseña una política de directivas de grupo adecuada a los requerimientos que se detallan a continuación. Deberás realizar esta configuración en **ServidorWindows** Antes de lanzarte a configurar directivas, **haz una planificación de las GPO que deberás crear**, nuevas unidades organizativas y grupos de seguridad si fuesen necesarios. Una vez tengas la planificación plasmada en papel, realiza los cambios necesarios para que la empresa se adapte a estas condiciones:
   - los miembros de los departamentos relacionados con la contabilidad, comercial, compras, ventas o finanzas de la empresa deberán tener estas limitaciones: se les **ocultará** la unidad C:\ de sus equipos, se ocultará el menú de opciones de carpeta para que no puedan ver los **ficheros ocultos** ni cambiar ninguna configuración y , por último, denegar el acceso (ni lectura ni escritura) a cualquier dispositivo extraíble.
   - en la empresa habrá una serie de empleados denominados **“Ayudantes TIC”** que tendrán una serie de privilegios para poder ayudar a los encargados del directorio. Éstos usuarios podrán realizar las siguientes configuraciones: modificar la configuración de red, el registro, instalar y desinstalar programas y modificar la apariencia del Escritorio.
   - algunos de los usuario del departamento **Comercial** requerirán salir de las oficinas con sus equipos portátiles, por lo que deberán disponer de ciertos privilegios: cambiar la configuración de red y tendrán acceso de lectura y de escritura a las unidades extraíbles.
   - se establecerá un tamaño máximo de 500 MB para la papelera de reciclaje a todos los usuarios, excepto a los miembros de TIC y Gerencia que no tendrán esta política establecida.
