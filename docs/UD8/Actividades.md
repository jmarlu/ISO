# Actividades de la UD8

# Actividad 1

1.  Crea la estructura de directorios usando el script que encontrarás en el Moodle del módulo. Para ello utiliza la carpeta Datos creada con anterioridad (recuerda que esta carpeta está montada en una de las particiones del segundo disco duro del servidor). Realiza esta tarea en los servidores **ServidorWindows** y en **ServidorUbuntu**.  
    Retoma el esquema de tu empresa y añade ahora la planificación de los permisos y privilegios de acceso a los recursos compartidos. Es conveniente que antes de lanzarse a implementar un sistema de permisos, éstos sean planificados con calma. Para ello sigue estas premisas:

    - debe denegar todos los permisos de forma predeterminada, de esta forma ningún usuario tendrá acceso a nada hasta que no pase por una adecuada planificación
    - debe permitir a cada usuario lo que esté destinado a hacer. Es buena idea que tan sólo tengan permiso a hacer lo que deben hacer
    - utiliza, si es posible, un sólo sistema de permisos. En sistemas de Windows existen dos sistemas, como ya veremos, a la hora de implantarlo, utiliza sólo uno de ellos para evitar contradicciones
    - crea grupos y unidades organizativas nuevas si es necesario para la correcta consecución de tus objetivos.

2.Una vez creada la estructura de carpetas, comparte y da permisos de escritura a la carpeta **Pruebas** a todos los empleados de la empresa, tanto en **ServidorWindows** a través de GUI como en **ServidorUbuntu** a través de CLI con `samba-tool`. Comprueba que los permisos funcionan de forma correcta usando este recurso desde un cliente del dominio.

# Actividad 2

1.  Implanta el modelo de permisos que has planificado en **ServidorWindows** a través de GUI. Debes probar cada configuración para verificar que su funcionamiento es correcto. Elabora una guía con los pasos que sigues para instaurar tu política de permisos, accesos y privilegios de usuario.
2.  Aplica ahora la siguiente configuración de permisos del resto de carpetas en ServidorWindows siguiendo estas premisas (si alguna de estas configuraciones coincide con tu planificación, no será necesario realizarla): - si no se especifica lo contrario, ningún usuario podrá acceder a ningún directorio de esta estructura (es la configuración inicial).

    - los miembros de un departamento tendrán acceso de lectura a la carpeta que tiene el nombre de ese departamento.
    - los responsables de cada departamento tendrán también permiso de escritura a su departamento.
    - los gerentes podrán leer en toda la estructura de carpetas y editar las carpetas Proceso de selección e Informe empleados de la carpeta Recursos Humanos.
    - cualquier empleado de la empresa podrá ver los documentos de la carpeta Asistencia dentro del directorio Servicio Técnico. El resto de carpetas dentro de Servicio Técnico no serán visibles para ellos.
    - los empleados que trabajen en el departamento de Administración pueden editar los ficheros contenidos en Campañas del directorio Comercial, pero no eliminar ni crear nuevos.
    - sólo los administradores y los miembros del Servicio Técnico tendrán permiso para modificar los ficheros de la carpeta Software (podrán eliminar, crear y ejecutar estos programas).

    Comprueba que la configuración es correcta accediendo desde diferentes clientes. Redacta una guía con los pasos que sigues para realizar esta tarea.

3.  Usa la misma estructura de directorios en **ServidorUbuntu** (creada con el shellscript que encontraste en el Moodle del módulo), en la carpeta **Datos** y asigna los siguientes permisos a través de CLI con la herramienta samba-tool:
    - cada departamento puede ver y leer los archivos de las carpetas que le correspondan, es decir, el departamento de RRHH sólo podrá ver y leer la carpeta RRHH
    - los **responsables** de cada departamento podrán escribir también en estas carpetas
    - las carpetas de **Software y Documentación** deben permanecer ocultas a los trabajadores que no pertenezcan al departamento de Servicio Técnico.
4.  En **ServidorWindows** crea una cuota de 500 MB al volumen **Perfiles**. Además se crearán varios umbrales de notificación; el primero al 80% de la capacidad el cual enviará un correo electrónico al administrador, y el segundo cuando la cuota alcance el 100% enviará un correo electrónico al usuario de la cuota. Las cuotas no se pueden superar en ningún caso. Escribe una guía detallada con los pasos que sigues para realizar esta configuración.
5.  A través de CLI en ServidorUbuntu, aplica una cuota a la carpeta **Perfiles** de _500 MB_ con un límite flexible de _700 MB_ durante dos semanas. Comprueba que las cuotas funcionan de forma adecuada. Redacta un documento con las configuraciones y comandos que utilizas para realizar esta tarea.
6.  En la carpeta **Datos** en **ServidorWindows** configura un filtro de ficheros para evitar que se guarden ficheros de audio o vídeo. De este modo evitaremos que los usuarios almacenen este tipo de ficheros en el servidor. Documenta el proceso con una pequeña guía.

!!! note annotate "Manera de entrega de las actividades"

      Redacta una guía de los pasos a seguir para realizar esta actividad y súbela al **Moodle** del módulo.
      De tal forma que en cada uno de los pasos incluya una imagen que **verifique** que se ha realizado aquello que se pide en cada uno de los ejercicios. Como en las anteriores actividades

!!! warning

      **SOLO LAS ACTIVIDADES 1,2 SON OBLIGATORIAS.**
