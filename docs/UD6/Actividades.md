# Actividades de la UD6

## Actividad 1

1. Es hora de retomar la empresa que creaste en una unidad pasada. Crea las cuentas de usuario necesarias para gestionarla en ServidorWindows. Deberás crear una cuenta de usuario por departamento, que actuará como responsable de ese departamento. Utiliza datos inventados para la información personal. Puedes usar esta web para obtener datos personales ficticios: https://www.generatedata.com. Haz pruebas de inicio de sesión en algún cliente para comprobar que las cuentas funcionan. Redacta un documento con los pasos que sigues ara realizar esta tarea, tan sólo será necesario la descripción de un usuario.
2. Crea esa estructura de usuarios en ServidorUbuntu pero en esta ocasión a través de CLI con el comando samba-tool user. Crea tan sólo las cuentas de los usuarios responsables de cada departamento. Prueba que las cuentas funcionan de forma correcta. Anota los pasos y los comandos necesarios para realizar esta tarea (es suficiente con detallar la creación de un usuario de cada tipo de cuenta).

## Actividad 2

1.  Crea el resto de cuentas de usuario necesarias para gestionar tu empresa. Utiliza plantillas de usuario para crear tres empleados por departamento en ServidorWindows. Las cuentas creadas deben tener las siguientes características:
    1.  todas las cuentas deben **cambiar su contraseña al primer inicio**
    2.  la mitad de los departamentos (a tu discreción) sólo podrán **iniciar sesión en CW1001** y la otra mitad en CW1002
    3.  la mitad de los departamentos tendrá horario de mañana (de 8 a 15) y la otra mitad en horario de tarde (de 15 a 22)
    4.  el departamento de TIC tendrá acceso a cualquier equipo en cualquier horario
    5.  Prueba a iniciar sesión con diferentes usuarios en diferentes clientes.
2.  Desde la directiva de contraseñas en ServidorWindows (en el panel de control de GPO) configura las contraseñas para que:
    1.  el historial de contraseñas sea de tres contraseñas guardadas
    2.  que la vigencia máxima de contraseña sea de 10 días y la mínima sea de 3 días
    3.  la longitud mínima de la contraseña sea de 5 caracteres
    4.  las contraseñas no deben cumplir los requerimientos de complejidad
3.  Configura las cuentas de usuario de responsables de departamento en ServidorWindows para que al inicio de sesión se ejecute el script `inicio.bat`. De nuevo, deberás modificar la plantilla necesaria. El script lo encontrarás en el Moodle del módulo.
4.  Configura las cuentas de usuario de responsables de departamento en ServidorUbuntu para que al inicio de sesión se ejecute el script `inicio.sh`.
5.  También desde el panel de control de GPO, cambia las **directivas de bloqueo**de este modo:
    1.  el umbral de bloqueo de cuentas a tres
    2.  la duración del bloqueo es de 2 minutos
    3.  el reestablecimiento de cuentas después del bloqueo a un minuto. ¿Qué ocurre si este valor es superior al del punto anterior?
    4.  Comprueba que las configuraciones son correctas haciendo intentos de inicio de sesión incorrectos.
6.  Utilizando el comando chage en ServidorUbuntu, crea las cuentas de los usuarios que pertenecen a cada departamento (mínimo una por departamento) que tengan estas limitaciones:

    1.  el usuario debe cambiar su contraseña en el siguiente inicio de sesión
    2.  que las cuentas de estos usuarios caducan a los 180 días
    3.  el usuario no podrá cambiar la contraseña hasta que no transcurran 7 días desde la última vez que la modificó
    4.  cualquier usuario debe cambiar su contraseña transcurridos 30 días
    5.  el sistema avisará con una semana de antelación del cambio de contraseña

7.  Configura un **perfil móvil** para los responsables de departamento creados con anterioridad. Usa la carpeta denominada Perfiles en ServidorWindows que contendrá los perfiles móviles de los usuarios. Deberás crear esa carpeta y asignar los permisos adecuados según se ha explicado en clase.
8.  Configura el perfil móvil para los responsables de departamento en **ServidorUbuntu**. Usa la carpeta Perfiles de igual modo que en ServidorWindows. Comprueba que la configuración es correcta y documenta el proceso.
9.  Los usuarios que no sean responsables de departamento, deben disponer de un lugar seguro para almacenar sus documentos. Configura una carpeta personal para cada uno de ellos. Para ello será necesario modificar las plantillas de usuario creadas con anterioridad. Esta carpeta será tendrá la unidad de red X:\ conectada en cada inicio de sesión. Crea la carpeta Datos en el servidor para contener estos directorios.
10. Crea para cada uno de los usuarios una carpeta personal en` /home/tu_dominio_empresa/%USER%/Datos`. Esta carpeta será montada al inicio del sistema en el directorio Datos situado en el escritorio del usuario actual (modifica el fichero `/etc/fstab`).

## Actividad 3. Refuerzo

1. Accede a la herramienta de políticas de grupo a través de <span class="menu">Herramientas</span> → <span class="menu">Políticas de grupo</span>. Desde allí <span class="menu">Default Domain Policy</span> → <span class="menu">Edit...</span> → <span class="menu">Configuración del equipo</span> → <span class="menu">Directivas</span> → <span class="menu">Configuración de Windows</span> → <span class="menu">Configuración de seguridad</span>. Sigue estos pasos para configurar las directivas de contraseñas:
   1. En Exigir historial de contraseñas cambia el valor a tres. ¿Qué quiere decir esta configuración?
   2. En Vigencia máxima de la contraseña introduce diez días
   3. En Vigencia mínima de la contraseña introduce tres días
   4. ¿Qué pasará al cuarto día según la configuración que acabas de poner?. ¿Que quieren decir estos dos umbrales?.
   5. En Longitud mínima de la contraseña pon tres caracteres.Deshabilita Las contraseñas deben cumplir los requerimientos de complejidad. Ten en cuenta que habilitar esta directiva sería contradictorio con el paso anterior. ¿Cuáles son esos requisitos de complejidad?. ¿Se pueden cambiar?.
   6. Almacenar contraseñas usando cifrado reversible déjalo deshabilitado. ¿Qué quiere decir esta configuración?. ¿Es compatible con la Ley Orgánica de Protección de Datos y porqué?.
      Haz pruebas para cambiar contraseñas a usuarios del dominio con las nuevas restricciones para comprobar que funcionan.
   7. Se necesita configurar los perfiles móviles a los miembros del departamento de Ventas, ya que no disponen de ordenador fijo y es conveniente que tengan acceso a todo su perfil desde cualquier equipo del dominio. Para ello, y desde <span class="menu">Herramientas</span> → <span class="menu">Usuarios y equipos de Active Directory</span>, accede a las propiedades de los usuarios y configura las opciones de los miembros del departamento Ventas de la siguiente manera:
      1. en ServidorWindows crea una carpeta con el nombre Perfiles (en la raíz de C:\), aquí colocaremos las carpetas de los perfiles móviles de cada usuario.
      2. **comparte** la carpeta y asegúrate que el grupo Todos tenga permisos de lectura y modificación en esta carpeta, tanto en la pestaña Compartir como en la de **Seguridad**
      3. abre las propiedades de un usuario del departamento de Ventas y en la ficha perfiles introduce la siguiente ruta del perfil: `\\NombredelControladorDominio\perfiles\%UserName%`
      4. **inicia sesión** en un equipo cliente con estos usuarios y comprueba que la configuración funciona
      5. ¿Qué es un perfil local?. ¿Es una buena configuración para un dominio?. ¿Qué es un perfil móvil?. ¿Presenta alguna ventaja o inconveniente con respecto a los perfiles locales?. ¿Cuáles?.

## Actividad 4. Ampliación

1.  Desde un cliente con el sistema operativo Microsoft Windows, instala el programa RSAT y administra el servidor UbuntuServer para crear tres usuarios en ese controlador. Estos usuarios estarán en un nuevo departamento denominado Programación que dependerá de TIC. Crea la estructura que estimes oportuna para añadir esta configuración.
2.  Elabora un documento con una introducción al sistema de inicio de sesión PAM para sistemas operativos GNU/Linux. Activa los módulos PAM en UbuntuServer para que:
    1.  sólo los **grupos** creados en del dominio puedan iniciar sesión (a través de sus gid)
    2.  establece que las contraseña de usuario deben tener una longitud de diez caracteres y tendrán tres reintentos de inicio de sesión. Al cuarto se bloqueará la sesión.
    3.  si cambian la contraseña, esta deberá tener, al menos, cinco caracteres deferentes a la anterior
3.  Configura un **perfil obligatorio** para de **ServidorWindows**. Comprueba que la configuración es correcta creando un nuevo usuario y documenta el proceso como de costumbre.

!!! note annotate "Manera de entrega de las actividades"

      Redacta una guía de los pasos a seguir para realizar esta actividad y súbela al **Moodle** del módulo.
      De tal forma que en cada uno de los pasos incluya una imagen que **verifique** que se ha realizado aquello que se pide en cada uno de los ejercicios. Como en las anteriores actividades

!!! warning

      **SOLO LAS ACTIVIDADES 1,2 SON OBLIGATORIAS.**
