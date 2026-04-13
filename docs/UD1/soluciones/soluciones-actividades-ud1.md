---
search:
  exclude: true
---
# Soluciones UD1 (estructura, BIOS y virtualización)

> Documento guía para resolver las actividades de la UD1.
>
> **Criterio usado en esta solución**:
> - Las actividades 1 y 2 se responden a partir de los ficheros `cuestionarios/t1Introduccion.gift` y `cuestionarios/t1.gift`.
> - En las actividades prácticas se propone una solución modelo coherente con el resto del curso.
> - Cuando un enunciado puede variar según fabricante o versión, se indican los nombres de opción más habituales.
>
> **Planificación base usada para que encaje con UD4 y UD5**:
> - `ServidorWindows`: `192.168.100.100/24`
> - `ServidorUbuntu`: `10.0.3.3/24`
> - red VirtualBox `NATwindows`: `192.168.100.0/24`, puerta de enlace `192.168.100.1`
> - red VirtualBox `NATlinux`: `10.0.3.0/24`, puerta de enlace `10.0.3.1`

---

## Actividad 1. Introducción

### Respuestas del cuestionario de introducción

1. Dos software de usuario:
   - Gestores de archivos
   - Navegadores
2. Tipos de lenguajes de programación de alto nivel:
   - Interpretados
   - Compilados
3. Software que se encarga de manejar al resto de programas:
   - `Sistema operativo`
4. El sistema operativo controla el:
   - `Hardware`
5. El sistema operativo asigna recursos de hardware al:
   - `software`
6. Las unidades que realizan operaciones matemáticas o lógicas son:
   - `Unidades Aritmético Lógicas`
7. Los registros del procesador son:
   - `Unidades de almacenamiento`
8. Elemento que permite saber la instrucción que se está ejecutando en cada momento:
   - `contador de programa`
9. Orden de mayor a menor nivel:
   1. Software de usuario
   2. Lenguajes de alto nivel
   3. Sistema operativo
   4. Kernel de Linux
   5. Hardware

---

## Actividad 2. Teoría de la estructura

### Respuestas del cuestionario de estructura y caracterización

1. ¿Qué es un sistema operativo?
   - Un software que administra los recursos y tareas de una computadora.
2. Tres ejemplos de sistemas operativos de uso común:
   - Windows, Mac y Linux.
3. Función principal de un sistema operativo:
   - Administrar el hardware y permitir que los programas se ejecuten.
4. Dos características principales del sistema operativo al actuar como interfaz del hardware:
   - Seguridad y abstracción.
5. Qué son los controladores de dispositivos:
   - Programas que permiten que el sistema operativo interactúe con hardware específico.
6. Papel del sistema operativo en la memoria secundaria:
   - Gestiona el espacio libre y, mediante el sistema de ficheros, gestiona su contenido.
7. Por qué es importante la administración de procesos:
   - Para el buen funcionamiento de los mismos.
8. Tarea incluida en la gestión de procesos:
   - Asignar recursos de CPU a aplicaciones en ejecución.
9. Qué es la gestión de dispositivos:
   - Proporciona una interfaz con los dispositivos de E/S.
10. Afirmación verdadera sobre memoria principal:
   - El SO gestiona los procesos que están en memoria principal de la manera más óptima.
11. Arquitectura monolítica:
   - Cuando falla una rutina falla todo el sistema.
12. Ventaja principal del microkernel:
   - Mayor simplicidad y modularidad, lo que facilita la extensión y el mantenimiento.
13. Arquitectura de capas y módulos:
   - Son similares, siendo la arquitectura por módulos mucho más flexible.
14. Afirmaciones verdaderas marcadas en el cuestionario:
   - El sistema operativo Linux es un sistema híbrido.
   - El sistema operativo Windows es un sistema híbrido.
15. Los sistemas operativos están estrechamente relacionados con la evolución del hardware:
   - Verdadero.
16. Afirmaciones verdaderas sobre evolución:
   - Un ordenador puede funcionar sin sistema operativo dependiendo de qué sistema se esté considerando.
   - Entre los años 70 y 80 se añadió al SO una capa de abstracción con el hardware que permitió crear sistemas más prácticos como Unix.
17. Diferencia entre sistema operativo de red y distribuido, según el cuestionario:
   - En un sistema operativo en red, los dispositivos se comunican entre sí y comparten recursos, mientras que en un sistema operativo distribuido, los dispositivos actúan de manera independiente sin compartir recursos.
18. ¿Un sistema operativo multitarea debe ser multiproceso?
   - No. Un sistema operativo multitarea puede ser monoproceso y aun así admitir ejecución concurrente de múltiples tareas.
19. ¿Puede venderse software de código abierto?
   - Sí, siempre que se cumplan las condiciones de la licencia correspondiente, incluido el acceso al código fuente cuando proceda.
20. Un editor de vídeo es software:
   - De propósito general.
21. Por qué se llama GNU/Linux:
   - Porque GNU aporta herramientas y utilidades que trabajan junto con el núcleo Linux.

!!! note

    En los puntos 14 y 17 se ha respetado la respuesta marcada como correcta en el banco `GIFT`. Como matiz teórico, Linux suele describirse como kernel monolítico modular, y un sistema distribuido sí coordina varios nodos entre sí.

---

## Actividad 3. BIOS

### Solución propuesta

1. Para reducir el tiempo de arranque hay que habilitar una opción del tipo:
   - `Quick Boot`
   - `Quick POST`
   - `Quick Power On Self Test`
2. La secuencia de arranque debe quedar con el disco duro o SSD en primera posición:
   - `Hard Disk` / `SSD` / `Windows Boot Manager` en primer lugar
   - DVD, USB o red después
3. Para proteger la configuración y el arranque:
   - en `Security` se configura `Supervisor Password` o `Administrator Password` para proteger la BIOS
   - si también se quiere bloquear el arranque, se añade `User Password`, `System Password` o `Power-On Password`
4. Para detener el arranque si aparece cualquier error en el POST, la opción habitual es:
   - `Halt On -> All Errors`
5. Para restaurar la configuración por defecto:
   - `Load Setup Defaults`
   - `Load Optimized Defaults`
   - `Restore Defaults`

!!! note

    Los nombres exactos cambian entre BIOS clásicas y UEFI modernas, pero la función es la misma. Si la actividad se hace sobre un equipo real, bastaba con localizar estas opciones sin guardar cambios peligrosos.

---

## Actividad 4. Virtualización. VirtualBox

### 1) Planificación inicial de máquinas virtuales

Una solución equilibrada y reutilizable para el resto del curso es esta:

| Máquina | Sistema | CPU | RAM | Disco principal | Red principal |
| --- | --- | --- | --- | --- | --- |
| `CW10XX` | Windows 10 Pro | 2 vCPU | 4 GB | 64 GB VDI dinámico | `NATwindows` |
| `CU18XX` | Ubuntu Desktop | 2 vCPU | 4 GB | 40 GB VDI dinámico | `NATlinux` |
| `ServidorWindows` | Windows Server | 2 vCPU | 4-6 GB | 80 GB VDI dinámico | `NATwindows` |
| `ServidorUbuntu` | Ubuntu Server | 2 vCPU | 2-4 GB | 40 GB VDI dinámico | `NATlinux` |

Si el anfitrión tiene pocos recursos, la prioridad debe ser que puedan arrancar al mismo tiempo un servidor y un cliente de cada familia sin agotar la RAM.

### 2) Redes virtuales

Para que luego coincida con UD4 y UD5:

- crea una red NAT llamada `NATwindows` con rango `192.168.100.0/24`
- crea una red NAT llamada `NATlinux` con rango `10.0.3.0/24`
- desactiva el DHCP de ambas para poder fijar IP manualmente en unidades posteriores
- conecta `CW10XX` y `ServidorWindows` a `NATwindows`
- conecta `CU18XX` y `ServidorUbuntu` a `NATlinux`
- comprueba que todas las MAC sean distintas regenerándolas si hace falta

### 3) Segunda NIC y disco adicional en servidores

En las máquinas con sistema operativo de red:

1. añade una segunda tarjeta de red
2. una configuración práctica para seguir el resto del temario es:
   - una NIC en la red NAT de prácticas
   - una NIC adicional en `Adaptador puente` o `Sólo-anfitrión` para administración desde el anfitrión
3. en `Configuración -> Almacenamiento` añade un controlador `SAS`
4. cuelga de ese controlador un disco duro nuevo de `300 GB`, `VDI`, `reservado dinámicamente`

Resultado esperado:

- `ServidorWindows`: disco principal + disco SAS de 300 GB
- `ServidorUbuntu`: disco principal + disco SAS de 300 GB

### 4) Instalación de los sistemas cliente

#### Windows 10 Professional

- instala usando todo el disco
- asigna un nombre provisional o directamente `CW10XX`
- una vez instalado, actualiza el sistema
- instala `Guest Additions`

#### Ubuntu Desktop

- instala usando todo el disco
- asigna un nombre provisional o directamente `CU18XX`
- completa usuario administrador y zona horaria
- instala `Guest Additions`

### 5) Instalación de los sistemas operativos de red

#### Windows Server

- usa todo el disco principal
- asigna el nombre `ServidorWindows`
- completa la instalación base
- instala `Guest Additions`

#### Ubuntu Server

- crea dos particiones durante la instalación:
  - una principal para `/`
  - una partición `swap`
- asigna el nombre `ServidorUbuntu`
- instala el sistema base
- instala `Guest Additions`

### 6) Carpeta compartida

Una solución válida es compartir el directorio del anfitrión `/home/julio` con todas las máquinas:

1. crea en VirtualBox una carpeta compartida con:
   - ruta: `/home/julio`
   - nombre: `home_julio`
   - automontaje activado
   - permanente
   - escritura permitida
2. en Windows accede a `\\VBOXSVR\home_julio` y crea un acceso directo en el escritorio del usuario administrador
3. en Ubuntu accede normalmente a `/media/sf_home_julio`
4. si en Ubuntu no deja escribir, añade el usuario administrador al grupo `vboxsf`:

```bash
sudo usermod -aG vboxsf <usuario>
```

Después basta con cerrar sesión o reiniciar y, si se quiere, crear un enlace simbólico al escritorio.

### 7) Clonado de servidores

Realiza un clon completo de `ServidorWindows` y de `ServidorUbuntu` cuando ya estén limpios, actualizados y con `Guest Additions`.

Ejemplo de nombres:

- `ServidorWindows-clon`
- `ServidorUbuntu-clon`

La idea es conservar una copia base estable antes de empezar configuraciones más delicadas.

### 8) Clonación enlazada de clientes

Haz clones enlazados a partir de los clientes base:

- desde `CW10XX` crea `CW1001`, `CW1002`, etc.
- desde `CU18XX` crea `CU1801`, `CU1802`, etc.

Reglas importantes:

- la máquina base debe quedar apagada y guardada como plantilla
- cada clon debe tener MAC distinta
- si luego usas IP fija, cada clon debe tener también IP distinta

---

## Actividades de refuerzo

### 1) Añadir un disco duro de 1 TB

En `ServidorWindows` y `ServidorUbuntu`:

1. `Configuración -> Almacenamiento`
2. sobre `Controlador SATA`, añadir nuevo disco
3. tipo `VDI`
4. `reservado dinámicamente`
5. tamaño `1 TB`

Al final, cada servidor debería tener:

- disco principal del sistema
- disco SAS de `300 GB`
- disco SATA de `1 TB`

### 2) Segunda instalación de Windows Server

Una solución ordenada es crear una nueva máquina llamada `ServidorWindows2` o `ServidorRespaldoBase`:

1. crea la máquina virtual
2. asocia la ISO de Windows Server al controlador IDE
3. comprueba que la unidad óptica arranca antes que el disco duro
4. inicia la máquina
5. completa la instalación del sistema
6. instala `Guest Additions`

---

## Actividad de ampliación

### 1) Modos de medios virtuales: inmutable, compartible y multiconexión

| Modo | Qué hace | Diferencia clave | Ejemplo de uso |
| --- | --- | --- | --- |
| `Inmutable` | Los cambios se guardan en un disco diferencial temporal y se descartan al apagar o reiniciar | Siempre vuelve al estado base | Aula de prácticas donde el cliente debe quedar limpio tras cada sesión |
| `Compartible` | Varias máquinas usan el mismo disco al mismo tiempo | El disco se comparte realmente entre varias VMs; requiere disco de tamaño fijo | Laboratorio de clúster o pruebas de almacenamiento compartido |
| `Multiconexión` | Varias máquinas parten del mismo disco base, pero cada una conserva su propio diferencial | Permite varias conexiones simultáneas y los cambios no se borran al apagar | Crear varios clientes de prueba desde una misma imagen base sin clonado completo |

Resumen rápido:

- `Inmutable`: vuelve siempre al estado inicial
- `Compartible`: varias máquinas escriben sobre el mismo disco compartido
- `Multiconexión`: comparten base, pero cada VM conserva su evolución

### 2) Guía breve para cifrar el disco principal en VirtualBox

1. apaga la máquina virtual
2. instala `VirtualBox Extension Pack` en el anfitrión
3. abre `Configuración -> General -> Cifrado`
4. marca `Habilitar cifrado`
5. elige `AES-128` o `AES-256`
6. introduce la contraseña y confirma
7. guarda los cambios y espera a que termine el proceso

Comprobación:

- el disco virtual queda cifrado
- no podrá reutilizarse libremente en otra VM sin conocer la contraseña

### 3) Plataforma de virtualización de nivel 1 con Proxmox

Guía resumida:

1. descarga la ISO de Proxmox
2. crea una VM nueva en VirtualBox
3. asigna, como mínimo, 2 vCPU, 8 GB de RAM si el anfitrión lo permite y 64 GB de disco
4. adjunta la ISO e instala Proxmox
5. configura la red de la VM como `Sólo-anfitrión`
6. arranca Proxmox y anota su IP
7. desde el navegador del anfitrión accede a `https://IP_DE_PROXMOX:8006`
8. crea dentro de Proxmox una máquina virtual para uno de los servidores

!!! warning

    Ejecutar Proxmox dentro de VirtualBox implica virtualización anidada. Puede funcionar para practicar, pero requiere que el anfitrión tenga soporte de virtualización por hardware activado y suficiente RAM.
