# Actividades de la UD5

## Actividad 1

1.  Accede al servicio DNS de ServidorWindows, accede a la zona directa existente y crea una nueva entrada tipo host (A) para cada equipo del dominio (clientes y servidores). Recuerda que, de momento, las IP de los equipos son fijas.
2.  En ServidorUbuntu crea una zona de búsqueda inversa. Recuerda que por defecto Samba no crea esta característica.

3.  Crea los siguientes alias (CNAME) en ServidorWindows:

    - uno denominado “www” que apunte al servidor,
    - otro“ftp” que apunte a uno de los clientes,
    - y un último “correo” que apunte a un equipo que no existe (IP inventada).

    Una vez creados ve al cliente y prueba las entradas que acabas de crear con los comandos `ping` y `nslookup`. ¿Qué ocurre en cada caso?. ¿Todo está funcionando como debiera?.

## Actividad 2

1.  Instala el rol de **DHCP en ServidorWindows** (no configures nada durante la instalación del servicio). Una vez terminada la instalación, configura el servicio de la siguiente manera:

    1.  crea un nuevo ámbito con todas las IP de la red
    2.  crea dos reservas; una con las 10 primeras IP de la red y otra con las 10 últimas
    3.  excluye de la asignación la IP del servidor
    4.  la duración de la concesión debe ser de 15 horas

2.  Instala el rol de **DHCP en ServidorUbuntu** y configura el servicio de la siguiente manera:
    1.  crea dos ámbitos: uno con el tercer byte de la dirección de tipo B a 0, y el otro con el resto de las direcciones disponibles.
    2.  crea dos reservas; una con las 5 primeras IP de la red y otra con las 5 últimas
    3.  reserva de la asignación la IP del servidor
    4.  la duración de la concesión debe ser de 15 horas, al igual que en el caso anterior

## Actividad 3

1.  Introduce el cliente **CW1001** en el dominio controlado por ServidorWindows. Recuerda que deberás realizar algunas configuraciones previas en los clientes.

    **IMPORTANTE:** Antes de continuar esta práctica, realiza una clonación enlazada de los clientes **CW10XX** las veces que necesites en lugar de crear máquinas nuevas. Recuerda que deberás cambiar el nombre del equipo, _la MAC de la NIC y la IP si es fija_.

2.  Clona de forma enlazada el **cliente CU1801** y mételo en el domino controlado por ServidorUbuntu. Recuerda que deberás realizar algunas configuraciones previas en los clientes

    **IMPORTANTE:** Al igual que en el caso anterior, realiza una clonación enlazada de los clientes **CU18XX** las veces que necesites en lugar de crear máquinas nuevas. Recuerda que deberás _cambiar el nombre del equipo, la MAC de la NIC y la IP_ si es fija.

## Actividad 4

1. Instala la aplicación **RSAT** en el cliente CW1001 y conecta con ServidorWindows para administrarlo.
2. Configura el programa **Open SSH Client** en el cliente CW1002 y trata de establecer una conexión con ServidorUbuntu. Realiza alguna operación con permisos de administración para comprobar que todo funciona de forma correcta.
3. Instala la aplicación **SSH** en el CU1801, _si es necesario_, y abre una sesión de administración en ServidorUbuntu. Trata de hacer alguna tarea que requiera permisos de administrador para comprobar que funciona la conexión.

## Actividad 5.DE REFUERZO

1.  Crearemos una serie de entradas en nuestro servicio DNS de ServidorWindows para hacer algunas pruebas. Sigue estos pasos:
    1. abre la herramienta de DNS a través de Herramientas → DNS y selecciona Zonas de búsqueda directa. Navega hasta el nombre de tu dominio y en el panel de la derecha pulsa el botón derecho y elige la opción Alias nuevo (CNAME)…
    2. introduce “Publicaciones” como nombre de alias y como nombre de dominio completo el de tu servidor (puedes buscarlo con el botón Examinar…)
    3. crea un host nuevo con la opción Host nuevo (A o AAA)… y coloca una IP que no esté asignada a ningún equipo del dominio, es decir, que no exista. De este modo comprobaremos lo que ocurre cuando el DNS falla
    4. añade un nuevo alias denominado “Proxy” que apunte al nuevo host que acabas de crear
    5. desde un cliente conectado al dominio, haz pruebas de conexión a ambos alias con el comando
    ```bash title=""
    nslookup publicaciones.tu_nombre_de_servidor.com
    ```
    Recuerda poner tu nombre de dominio después del nombre del alias. ¿Qué resultados obtienes?. ¿Son lógicos?.
2.  Configura ahora un ámbito nuevo como respaldo del primero, para realizar tareas de mantenimiento y no dejar a los clientes sin conexión de red. Para ello sigue los pasos siguientes:
    1. pulsa con el botón derecho sobre el servidor DHCP y elige Ámbito nuevo…. Define como nombre de ámbito Segundo. El rango de direcciones serán las 30 últimas del ámbito (excepto la última, recuerda que es la de broadcast).
    2. **define la exclusión** de la última IP del ámbito. ¿Qué significa esta configuración?
    3. **duración** de concesiones 8 horas. ¿Qué quiere decir esto?
    4. **configura la puerta de enlace predeterminada** de tu red como la dirección IP del servidor. Para ello accede a la opción Opciones de ámbito.
    5. **desactiva el ámbito** anterior, si es que se encuentra activo
    6. **activa el ámbito**, prepara a los clientes para que obtengan IP automática (Configuración de red)
    7. **comprueba la IP** que se le ha asignado al equipo tras el reinicio.
3.  Es necesario la administración de los clientes de la red, y estos es posible que tengan diferentes sistemas operativos. Para poder realizar esta administración entre ellos se configurará Open SSH client y server en los clientes con un sistema operativo Microsoft Windows. Para ello sigue estos pasos:

    1.  accede a <span class="menu">Aplicaciones y Características</span> → <span class="menu">Administrar funciones adicionales</span> → <span class="menu">Agregar una característica e instala la característica</span> Servidor OpenSHH. Comprueba que tanto el cliente como el servidor de Open SSH están instalados en el equipo
    2.  será necesario crear una regla en el Cortafuegos de Windows para poder utilizar esta aplicación. Para ello abre un terminal PowerShell como administrador e introduce este comando:
        ```bash
        netsh advfirewall firewall add rule name="SSHD Port" dir=in action=allow protocol=TCP localport=22
        ```
    3.  ahora se va a conectar a este equipo desde un cliente con GNU/Linux. Primero será necesario instalar el cliente:
        ```bash
        sudo apt-get install openssh-client
        ```
    4.  es preciso disponer de varios datos para realizar la conexión; el puerto por el que escucha el servicio (será el 22), la IP del equipo, el nombre y la contraseña de usuario con el que se requiere conectar. Con estos datos se establece la conexión con el siguiente comando:

        ```bash

        ssh -p 22 nombre_usuario@ip_equipo

        ```

        donde será necesario sustituir los datos de usuario y la IP del equipo. Preguntará la contraseña del usuario al realizar la conexión

    5.  Ahora instala en servidor OpenSHH en el cliente con GNU/Linux y realiza la conexión en sentido contrario, es decir, desde Microsoft Windows a GNU/Linux. Para ello será necesario la instalación del software a través de este comando:

        ```bash
          sudo apt install openssh-server
        ```

        recuerda revisar la configuración del archivo `/etc/ssh/sshd_config` para comprobar si el servicio está escuchando a través del puerto 22.

## Actividad 6.DE AMPLIACIÓN

1. ¿Qué es un superámbito en los servicios DHCP?. Explica en qué consiste y configura uno a partir de dos nuevos ámbitos que deberás crear; uno para el departamento de Contabilidad y otro para el de TIC. Usa los rangos de IP que estimes oportunos
2. Introduce el cliente CU1801 en el dominio controlado por ServidorUbuntu y su clon enlazado en el dominio controlado por ServidorWindows. Utiliza para ello la aplicación LikeWise-Open o SSSD que deberás instalar.
3. Instala la aplicación RSAT en el cliente CW1001 (clonado) y conecta con ServidorUbuntu para administrarlo.

!!! note annotate "Manera de entrega de las actividades"

      Redacta una guía de los pasos a seguir para realizar esta actividad y súbela al **Moodle** del módulo.
      De tal forma que en cada uno de los pasos incluya una imagen que **verifique** que se ha realizado aquello que se pide en cada uno de los ejercicios. Como en las anteriores actividades

!!! warning

      **SOLO LAS ACTIVIDADES 1,2,3,4 SON OBLIGATORIAS.**
