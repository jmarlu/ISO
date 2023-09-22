# Actividades de la UD1

## Actividad 1. Introducción

Si bien para nosotros ya es algo común, originalmente el concepto de PC (acrónimo de las palabras inglesas Personal Computer, es decir, Computadora Personal) era algo impensado, considerándose de que los primeros ordenadores podían inclusive ocupar habitaciones enteras. Este término, si bien actualmente es un genérico para todos los equipos sin importar su fabricante o sistema operativo, en un principio pertenecía exclusivamente al ordenador llamado IBM Personal Computer, desarrollado por la firma IBM y comercializado a principios de los años '80, contando con un precario procesador 8066 con una capacidad de 4.77 MHz y una memoria ROM de 64 Kb, algo que lógicamente está más que obsoleto hoy en día.
En cuanto a los ordenadores en sí, podemos contar con la clasificación actual en estos tipos de equipo:

- **Ordenadores de Sobremesa**: Los clásicos, también llamados De Escritorio, con su torre, monitor y periféricos.
- **Ordenadores Portátiles**: Comprende al grupo de las Laptops, Netbooks, Notebooks y demás variantes.
- **Ordenadores Todo en Uno**: En el monitor integran todos los componentes de Hardware Internos, teniendo generalmente una Pantalla Táctil para su control.

El objetivo de estos ejercicios es tener una visión de los niveles que existen dentro de nuestro PC para así, ir profundizando en nuestro conocimiento sobre este dispositivo.

Visualiza el siguiente [vídeo](https://www.youtube.com/watch?v=iOQnZKJ3fls&ab_channel=AntonioSarosi) y responde a las preguntas del _cuestionario de Introducción_ que está en aules. Se recomienda leer cada cuestión antes de visualizarlo, parar el vídeo si algo no se entiende para volver a verlo.

## Actividad 2. Teoría de la Estructura

Responde al _cuestionario de la estructura y caracterización_. Este cuestionario lo podéis realizar todas la veces que queráis hasta que tengáis todas las respuestas. Os servirá para estudiar el tema.

## Actividad BIOS

El manejo de la BIOS puede resultar en la pérdida de prestaciones del equipo, al menos temporalmente. Por ese motivo es posible hacer esta práctica de dos formas:

- trabajando sobre un emulador de BIOS:

      - https://www.grs-software.de/sims/bios/phoenix/pages/
      - https://geekprank.com/bios/

sobre la BIOS/UEFI de un equipo real (si usas esta opción tendrás que hacer fotos con tu dispositivo móvil de la pantalla). **Tan sólo localiza las opciones pero no apliques los cambios. De este modo evitaremos problemas.**

Hay que tener en cuenta que algunas de las preguntas no las podrás contestar al no existir dicha opción en la simulación, pero será suficiente para hacerse una idea de su funcionamiento.

1. Al arrancar el PC, la BIOS ejecuta inmediatamente una serie de test, muy rápidos, sobre el funcionamiento de los componentes del sistema. Estos test consumen una parte del tiempo de arranque de PC, de forma que se pueden deshabilitar en la BIOS, aunque conviene ejecutarlos de vez en cuando.
   Deshabilita estos test iniciales buscando una entrada en la BIOS con el título **"Quick Boot", "Quick POST" o "Quick Power on SelfTest"** y habilitándola.
2. Es normal que los equipos estén configurados para arrancar desde CD/DVD u otro dispositivo de almacenamiento antes de arrancar desde el disco duro. Su utilidad es importante, ya que nos permite arrancar desde un medio alternativo si nuestro sistema operativo no responde. Pero lo cierto es que podemos desactivar esta opción, pidiendo al ordenador que solo arranque desde el disco duro, ya que en caso de problemas, siempre podremos restaurar el arranque desde otro medio. **Comprueba la secuencia de arranque en la BIOS y configúrala para arrancar directamente desde el disco duro.**
3. Es posible evitar las modificaciones no deseadas, limitando el acceso a la configuración de la BIOS a personas no autorizadas. Es posible añadir una contraseña para impedir el acceso al sistema operativo a personas no autorizadas. Asigna una contraseña de acceso al sistema.
4. Si queremos que el ordenador detenga su arranque cuando se da cualquier problema en la ejecución del POST. ¿Qué opción debemos habilitar en la BIOS?
5. Tras realizar varios cambios en la BIOS, te das cuenta de que el sistema no está funcionando correctam
   ente. ¿Qué opción tenemos para restaurar los valores por defecto del sistema y solucionar el problema?

## Actividad 3. Virtualización. Virtual Box

1. Crea una máquina virtual para cada uno de los siguientes sistemas operativos. Antes de crearlas se ha de tener en cuenta **los requisitos con los que dispone el sistema anfitrión** y que, en circunstancias normales, serán necesarias **dos de estas máquinas** encendidas a la vez. Debes planificar bien el consumo de recursos:

   - una máquina para un cliente con Microsoft Windows 10 Professional .
   - una máquina para un cliente con Ubuntu Desktop.
   - una máquina para un servidor con Microsoft Windows Server.
   - una máquina para contener un servidor con Ubuntu Server.

2. Crea una red virtual interna NAT para cada servidor e introduce en ella todas las máquinas virtuales separadas por sistemas operativos; los de Microsoft en una red y los de GNU/Linux en otra. Asegúrate que las direcciones MAC de las tarjetas de red no se repitan.
3. En las máquinas virtuales que contienen un **sistema operativo de red**, configura una segunda tarjeta de red e instala un nuevo controlador **SAS**. Agrega un nuevo disco duro de **300 GB **de capacidad al nuevo controlador y con expansión dinámica.

4. **Descarga** las imágenes de los sistemas operativos cliente e instala cada uno de ellos en la máquina virtual correspondiente. Deberás instalar Microsoft Windows 10 Professional y Ubuntu Desktop siguiendo estas indicaciones:
   - deberás usar **todo el disco duro** para la instalación
   - el nombre de la máquina queda a tu discreción
   - instala las **Guest Additions** en cada máquina, esto facilitará el trabajo con ellas
5. Instala los sistemas operativos de red en la máquina virtual correspondiente. Deberás instalar Microsoft Windows Server y Ubuntu Server siguiendo estas indicaciones:

   - deberás usar **todo el disco duro** para la instalación del sistema operativo Microsoft Windows
   - **crea dos particiones**, una de ellas será **swap**, durante el proceso de instalación de **Ubuntu Server**
   - el nombre de la máquina queda a tu discreción
   - instala las **Guest Additions** en cada máquina, esto facilitará el trabajo con ellas

6. Crea una **carpeta compartida** en cada máquina virtual que conecte el directorio **/home** de tu usuario a una carpeta en el escritorio del usuario administrador. **Se podrá escribir** en ella en todos los casos.
7. Realiza el **clonado** de las máquinas que disponen de un sistema operativo de red.
8. Realiza una **clonación enlazada** de cada uno de los clientes. Estas nuevas máquinas **serán utilizadas para la realización de las actividades. Las máquinas originales se guardarán como copia de seguridad en caso necesario**.

## Actividad 4. Creación de máquinas virtuales. LXD

Con finalidades didácticas se va a utilizar como host anfitrión de los contenedores una MV con Ubuntu Desktop. Pero realmente esta configuración tendrá más gracia **si el host es el ordenador físico**.

1. Lance un contenedor LXD con Ubuntu (la última versión) tenga por nombre u1.
2. Liste los contenedores en ejecución.
3. Liste las imágenes disponibles localmente.
4. Abra un terminal en el contenedor u1.
5. Detener un contenedor
6. Listar todos los contenedores, los arrancados y los detenidos
7. Encender un contenedor detenido
8. ¿Qué cantidad de memoria RAM está disponible para el contenedor? ¿Cómo la puede limitar a 1GiB?
9. Agregue una segunda interfaz de red al contenedor.
10. Eliminar un contenedor

<!-- ## Actividad 5. Creación de máquinas virtuales en Windows.LXD.

Vamos a crear contenedores lxc, pero ahora desde Windows. Para lo cual deberás ver el siguiente [video](https://www.youtube.com/watch?v=KcSB2B3N4Fg). La actividad consistirá
Para llevar a cabo este ejercicio date cuenta que tienes que instalar en windows el gestor de paquetes llamado [chocolatey](https://chocolatey.org/). -->

## Actividades 5.De refuerzo.

1.  Añade un nuevo disco duro virtual a las máquinas virtuales que contendrán los sistemas operativos de red. Estos discos tendrán una capacidad de 1 TB, SATA y de expansión dinámica. Para hacerlo, sigue estos pasos:

    - Selecciona la máquina → <span class="menu"> Configuración </span> → <span class="menu">Almacenamiento </span> → <span class="menu">Controlador: SATA </span>, botón derecho y seleccionar la opción <span class="menu">Agregar disco duro </span>

    - en la ventana que aparece elegiremos <span class="menu"> nuevo disco </span>
    - cuando aparezca una nueva ventana, dale un nombre, selecciona el **tamaño**, tipo **VDI** y Reservado **dinámicamente**

2.  Crea una nueva máquina virtual para contener una segunda instalación de Microsoft Windows Server que usaremos en lo sucesivo.
    Para ello sigue estos pasos:

    - selecciona la máquina → <span class="menu">Configuración</span> → <span class="menu">Almacenamiento</span> → <span class="menu">Controlador: IDE</span>, y selecciona el dispositivo virtual disponible (debe aparecer con la palabra “Vacío”)
    - despliega el icono del disco azul que aparece a la derecha y elige la opción <span class="menu">Seleccione archivo de disco óptico virtual...</span>, busca la imagen que has descargado en tu ordenador (verás que su nombre aparece donde antes lo hacía la palabra “Vacío”)
    - ahora ve a <span class="menu">Configuración</span> → <span class="menu">Sistema</span> y comprueba que la unidad óptica está delante del disco duro en la secuencia de arranque. Si no es así, modifica el orden con las flechas que aparecen a la derecha
    - **inicia la máquina** y sigue el asistente de instalación del sistema operativo.

## Actividades 6. De Ampliación.

1.  Investiga el modo de utilización de los modos de medios virtuales inmutable, compartible y multiconexión. Identifica sus diferencias y pon un ejemplo de uso en cada caso.
2.  Para las máquinas virtuales con un sistema operativo de red, encripta el disco duro principal. Recuerda que para ello deberás instalar las herramientas de VirtualBox Extension Pack. Redacta una breve guía de como se realizan estos pasos y súbela al Moodle del módulo.
3.  Crea una plataforma de virtualización de nivel 1 con el sistema operativo PROXMOX siguiendo los siguientes pasos:

    - descarga la imagen de instalación desde su página [web] (https://www.proxmox.com/en/)
    - crea una máquina virtual para **PROXMOX** e instala este sistema operativo
    - configura la red como adaptador sólo-anfitrión
    - accede a **PROXMOX** a través del navegador web de la máquina anfitrión (puerto 8006)
    - crea una máquina virtual para contener uno de los servidores

!!! note annotate "Manera de entrega de las actividades"

      Redacta una guía de los pasos a seguir para realizar esta actividad y súbela al **Moodle** del módulo.
      De tal forma que en cada uno de los pasos incluya una imagen que **verifique** que se ha realizado aquello que se pide en cada uno de los ejercicios.

      **Ejemplo:** En el **Ejercicio 4 de la Actividad 3** cuando se debe instalar el sistema operativo, por ejemplo se podría hacer una captura de pantalla cuando se ponga el nombre se usuario ,cuando se haga dos particiones como te indica el ejercicio y así sucesivamente con los objetivos que te he marcado en ese ejercicio. De esta manera, demuestras que es tu máquina y que has realizado aquello que te he pedido. **NO TIENES QUE HACER CAPTURAS DE TODOS LOS PASOS**.

!!! warning

      **SOLO LAS ACTIVIDADES 1,2,3,4,BIOS SON OBLIGATORIAS.**
