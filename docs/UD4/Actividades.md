# Actividades de la UD4

## Actividad 1

Antes de abordar la configuración los servicios de directorio, crea una empresa imaginaria. Debes especificar nombre, dirección, actividad, debe disponer de varias sedes físicas y establece una estructura en departamentos basada en estas premisas:

1. un departamento encargado de la **gerencia** de la empresa. Habitualmente suelen tener acceso a toda la información de la empresa, pero no a los pormenores de la configuración del sistema
2. otro de encargará de la **administración** de la empresa. En normal que ante la amplitud de tareas que este departamento posee se divida en varios, como por ejemplo uno encargado de las **finanzas**, otro de las **nóminas** o de la **contabilidad**.
3. la empresa que diseñas se encarga de la fabricación y venta, por lo que un departamento encargado de la gestión de estos menesteres será necesario. Es posible que requieras controlar las **compras**, las ventas así como la gestión de **inventario**.
4. otra de las actividades que seguro necesitarás en tu empresa será la gestión de **recursos humanos**, así como la de controlar la mercadotécnica de tus productos.
5. además, debes contar con un buen **servicio técnico** que realice las tareas de **diseño**, **implementación** y **mantenimiento** de la infraestructura informática.

Haz un pequeño organigrama y descripción de tu empresa.

## Actividad 2

1.  Configura los adaptadores de red de los equipos con un sistema operativo de **Microsoft Windows** con una dirección **IP fija**. Recuerda q**ue se encuentran dentro de una Red Interna NAT** que se creó en la **UT02**. Usa un rango de **IPv4** privadas de **tipo C**. En los clientes configura las **DNS** para que apunten a la IP del servidor **Windows Server**.
2.  Configura los adaptadores de red a través de CLI de los equipos con un sistema operativo **GNU/Linux** con una dirección IP fija. Recuerda que estos equipos también están ubicados dentro de una **Red Interna NAT**. Usa un rango de IPv4 privadas del **tipo B**. En los clientes configura las DNS para que apunten a la IP del servidor **Ubuntu Server**. Redacta un documento con los pasos que sigues para realizar esta tarea.

3.  Cambia el nombre de los equipos según este listado:

    - **ServidorWindows** para Microsoft Windows Server
    - **CW10XX** para Microsoft Windows 10 Professional

    Las XX representan el número de equipos que se van introduciendo en el directorio, siendo 01 el primero y aumentando de uno en uno.

4.  Cambia el nombre de los equipos según este listado:

    - **ServidorUbuntu** para Ubuntu Server
    - **CU18XX** para Ubuntu Desktop

    Las XX representan el número de equipos que se van introduciendo en el directorio, siendo 01 el primero y aumentando de uno en uno.

5.  Instala los servicios de directorio en **Microsoft Windows Server** con los siguientes datos:

    - nombre de dominio, el de tu empresa con la extensión .local, por ejemplo, miempresafea.local. Recuerda que no es buena práctica utilizar esta extensión si es necesario usar los servicios de un ISP público.
    - debe ser servidor principal de DNS, como ya se ha explicado.
    - la contraseña para la cuenta administrador del dominio debe ser P4ssw0rd##, en todos los servidores que conformen el directorio.

6.  Instala un servicio de directorio en Ubuntu Server a través del CLI. Utiliza los mismos datos que en el caso anterior.

## Actividad 3. De refuerzo

1. Configura la red del equipo UbuntuServer para que su IP sea fija y, ademas, sea la 10.0.0.1 Para ello deberás seguir estos pasos:

   1. **genera** un fichero de configuración con el comando:
      ```bash title=""
      sudo netplan generate
      ```
   2. **edita** el fichero yaml que se acaba de generar

      ```bash title=""
      sudo nano /etc/netplan/01-netcfg.yaml

      ```

   3. el contenido que debe tener el fichero será el siguiente (presta atención al nombre del NIC):

      ```bash title=""
      enp0s3:
      dhcp4: no
      addresses: [10.0.0.1, ]
      gateway4: 10.0.0.1
      nameservers:
      addresses: [8.8.8.8, 8.8.4.4]

      ```

      ¿Qué quiere decir esta configuración?. Describe cada una de las líneas que compone esta configuración.

   4. **aplica** el nuevo plan con el comando

   ```bash title=""
   sudo netplan apply
   ```

Comprueba que todo ha funcionado bien y redacta un documento con el resultado del comando `ifconfig` para que muestre la configuración de la red.

1. En el manual del módulo encontrarás una guía que detalla paso a paso cómo instalar y configurar un servicio de directorio en Ubuntu Server con Samba. Sigue la con detenimiento y crea un documento con los resultados que obtienes de la instalación de cada servicio. Una vez terminada la instalación de todos los servicios, realiza una captura al resultado del comando:

   ```bash title=""
      samba-tool domain level show
   ```

## Actividad 3. De Ampliación

1. Investiga el concepto de **“Sitio”** en los servicios de directorio y **planifica su creación** así como la asignación de una **subred** para cada sitio planificado. Elabora una pequeña guía con los datos y las herramientas de las que disponen los SOR para crear estos objetos.
2. Es interesante que en dominio exista un **segundo** servidor por si el primero tuviese algún problema. Este segundo controlador se mantendrá en la sombra hasta que el primero tenga algún problema, será entonces cuando cobre protagonismo. Configura un servidor de backup en el dominio controlado con Windows Server siguiendo estos pasos:

   - haz una clonación **enlazada** del clon de la máquina que contiene el sistema operativo de red de Microsoft.
   - **configura la red** de forma adecuada y cámbiale el nombre a **ServidorRespaldo**.
   - Instala las herramientas necesarias para que se convierta en **controlador de dominio** de igual modo que hiciste con el servidor principal.
   - **promociona** este equipo a servidor de respaldo.

3. Repite los pasos del ejercicio anterior para crear un servidor de respaldo para **ServidorUbuntu**. Tendrás que realizar todo este proceso a través de **CLI**. Anota cada uno de los pasos que necesitas para hacer esta tarea en un documento.

!!! note annotate "Manera de entrega de las actividades"

      Redacta una guía de los pasos a seguir para realizar esta actividad y súbela al **Moodle** del módulo.
      De tal forma que en cada uno de los pasos incluya una imagen que **verifique** que se ha realizado aquello que se pide en cada uno de los ejercicios. Como en las anteriores actividades

!!! warning

      **SOLO LAS ACTIVIDADES 1,2 SON OBLIGATORIAS.**
