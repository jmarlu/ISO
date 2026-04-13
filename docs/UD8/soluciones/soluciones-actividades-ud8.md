---
search:
  exclude: true
---
# Soluciones UD8 (permisos, herencia, cuotas y filtrado)

> Documento guia para resolver las actividades de la UD8.
>
> **Supuestos usados en esta solucion**:
> - El dominio sigue el esquema de unidades anteriores: `miempresafea.local`.
> - Los servidores se llaman `ServidorWindows` y `ServidorUbuntu`.
> - El script del Moodle no esta incluido en este repositorio. Por eso se documenta una estructura de carpetas equivalente.
> - Se usa el patron recomendado en UD7: `GG_*` para grupos globales de personas y `DL_*` para grupos locales de dominio asociados a recursos.
>
> **Rutas de referencia usadas**:
> - `ServidorWindows`: `D:\Datos` para datos compartidos y `C:\Perfiles` para perfiles moviles.
> - `ServidorUbuntu`: `/media/Datos` para datos compartidos y `/media/Perfiles` como punto de montaje dedicado para cuotas de perfiles.

---

## Estructura base asumida

Si tu script del Moodle genera otros nombres, cambia solo la ruta, no la logica de permisos.

```text
Datos/
├── Administracion/
├── Comercial/
│   └── Campanas/
├── Gerencia/
├── Pruebas/
├── RRHH/
│   ├── Informe empleados/
│   └── Proceso de seleccion/
└── ServicioTecnico/
    ├── Asistencia/
    ├── Documentacion/
    └── Software/
```

## Grupos recomendados

### Grupos globales de personas

- `GG_Empleados`
- `GG_Gerencia`
- `GG_Administracion`
- `GG_Comercial`
- `GG_RRHH`
- `GG_ServicioTecnico`
- `GG_Resp_Administracion`
- `GG_Resp_Comercial`
- `GG_Resp_RRHH`
- `GG_Resp_ServicioTecnico`

### Grupos locales de dominio para recursos

- `DL_Pruebas_RW`
- `DL_Admin_R`
- `DL_Admin_RW`
- `DL_Comercial_R`
- `DL_Comercial_RW`
- `DL_RRHH_R`
- `DL_RRHH_RW`
- `DL_RRHH_Proceso_RW`
- `DL_RRHH_Informe_RW`
- `DL_ST_Asistencia_R`
- `DL_ST_Software_RW`
- `DL_ST_Documentacion_RW`
- `DL_Campanas_EditSinBorrar`
- `DL_Datos_Gerencia_R`

### Anidamiento recomendado

- `GG_Empleados` -> `DL_Pruebas_RW`
- `GG_Administracion` -> `DL_Admin_R`
- `GG_Resp_Administracion` -> `DL_Admin_RW`
- `GG_Comercial` -> `DL_Comercial_R`
- `GG_Resp_Comercial` -> `DL_Comercial_RW`
- `GG_RRHH` -> `DL_RRHH_R`
- `GG_Resp_RRHH` -> `DL_RRHH_RW`
- `GG_Gerencia` -> `DL_Datos_Gerencia_R`
- `GG_Gerencia` -> `DL_RRHH_Proceso_RW`
- `GG_Gerencia` -> `DL_RRHH_Informe_RW`
- `GG_Empleados` -> `DL_ST_Asistencia_R`
- `GG_Administracion` -> `DL_Campanas_EditSinBorrar`
- `GG_ServicioTecnico` -> `DL_ST_Software_RW`
- `Domain Admins` -> `DL_ST_Software_RW`
- `GG_ServicioTecnico` -> `DL_ST_Documentacion_RW`

---

## Actividad 1

### 1) Crear la estructura y planificar permisos

La solucion recomendable es:

1. Crear toda la estructura con una cuenta administrativa.
2. Dejar denegado el acceso por defecto:
   - quitar herencia en la raiz `Datos`
   - eliminar `Users`, `Authenticated Users` o equivalentes si han quedado con permisos
   - mantener solo `Administrators`, `SYSTEM` y, si procede, `Domain Admins`
3. No dar permisos directos a usuarios.
4. Dar permisos a grupos.
5. Usar un solo sistema de control real:
   - en Windows, compartir amplio y controlar por NTFS
   - en Ubuntu, compartir por Samba y controlar con ACL del sistema de ficheros

### 2) Compartir `Pruebas` con escritura para todos los empleados

#### En ServidorWindows (GUI)

1. Clic derecho sobre `D:\Datos\Pruebas` -> `Propiedades`.
2. En `Compartir` -> `Uso compartido avanzado`:
   - compartir como `Pruebas`
   - dejar `Administrators` con `Control total`
   - si quieres simplificar el compartido, deja `Authenticated Users` con `Control total`
3. En `Seguridad`:
   - agregar `DL_Pruebas_RW`
   - permiso `Modificar`
4. Como `GG_Empleados` esta anidado en `DL_Pruebas_RW`, todos los empleados podran leer, crear, modificar y borrar dentro de `Pruebas`.
5. Verificacion:
   - entrar desde `CW1001` con un usuario normal
   - abrir `\\ServidorWindows\Pruebas`
   - crear y editar un fichero

#### En ServidorUbuntu (CLI)

En Samba el recurso compartido se declara en `smb.conf`. `samba-tool` se usa para grupos y comprobacion de ACL.

Ejemplo de recurso:

```ini
[Pruebas]
path = /media/Datos/Pruebas
read only = No
```

Permisos de sistema de ficheros:

```bash
sudo chown -R root:"Domain Admins" /media/Datos/Pruebas
sudo chmod 2770 /media/Datos/Pruebas
sudo setfacl -b /media/Datos/Pruebas
sudo setfacl -m g:GG_Empleados:rwx /media/Datos/Pruebas
sudo setfacl -d -m g:GG_Empleados:rwx /media/Datos/Pruebas
sudo setfacl -m g:"Domain Admins":rwx /media/Datos/Pruebas
sudo setfacl -d -m g:"Domain Admins":rwx /media/Datos/Pruebas
sudo systemctl restart samba-ad-dc
```

Validacion:

```bash
getfacl /media/Datos/Pruebas
samba-tool ntacl get /media/Datos/Pruebas
```

Prueba funcional:

- abrir `\\ServidorUbuntu\Pruebas` desde un cliente del dominio
- crear un fichero de prueba
- modificarlo y borrarlo

---

## Actividad 2

### 1) Implantar el modelo de permisos en ServidorWindows

La idea es aplicar `AGLP`:

- cuentas de usuario -> `GG_*`
- `GG_*` anidados en `DL_*`
- `DL_*` con permisos sobre carpetas

Pasos:

1. Crear o revisar los grupos en `Usuarios y equipos de Active Directory`.
2. En `D:\Datos`, romper herencia:
   - `Propiedades -> Seguridad -> Opciones avanzadas -> Deshabilitar herencia`
3. Convertir permisos heredados a explicitos y eliminar los innecesarios.
4. Mantener solo:
   - `SYSTEM`
   - `Administrators`
   - `Domain Admins`
5. Crear grupos `DL_*` y anidar los `GG_*` correspondientes.
6. Asignar permisos NTFS carpeta por carpeta.
7. Validar con `Acceso efectivo` y con cuentas reales.

### 2) Permisos especificos en ServidorWindows

#### Matriz resumida

| Carpeta | Grupo | Permiso |
| --- | --- | --- |
| `Administracion` | `DL_Admin_R` | Lectura |
| `Administracion` | `DL_Admin_RW` | Modificar |
| `Comercial` | `DL_Comercial_R` | Lectura |
| `Comercial` | `DL_Comercial_RW` | Modificar |
| `RRHH` | `DL_RRHH_R` | Lectura |
| `RRHH` | `DL_RRHH_RW` | Modificar |
| `Pruebas` | `DL_Pruebas_RW` | Modificar |
| toda `Datos` | `DL_Datos_Gerencia_R` | Lectura |
| `RRHH/Proceso de seleccion` | `DL_RRHH_Proceso_RW` | Modificar |
| `RRHH/Informe empleados` | `DL_RRHH_Informe_RW` | Modificar |
| `ServicioTecnico/Asistencia` | `DL_ST_Asistencia_R` | Lectura |
| `ServicioTecnico/Software` | `DL_ST_Software_RW` | Modificar |
| `ServicioTecnico/Documentacion` | `DL_ST_Documentacion_RW` | Modificar |

#### Casos especiales

##### a) Gerencia lee toda la estructura y edita dos subcarpetas de RRHH

1. En `D:\Datos`, asignar `Lectura y ejecucion` a `DL_Datos_Gerencia_R`.
2. En `RRHH\Proceso de seleccion`, romper herencia si hace falta y dar `Modificar` a `DL_RRHH_Proceso_RW`.
3. En `RRHH\Informe empleados`, hacer lo mismo con `DL_RRHH_Informe_RW`.

##### b) Cualquier empleado puede ver `Asistencia`, pero no el resto de Servicio Tecnico

1. En `ServicioTecnico`, dejar acceso solo a `GG_ServicioTecnico`, administradores y sistema.
2. En `ServicioTecnico\Asistencia`, agregar `DL_ST_Asistencia_R` con `Lectura`.
3. Si quieres que ademas no se muestren otras carpetas del recurso al listar desde red, activa `Access-Based Enumeration` en el recurso compartido.

##### c) Administracion puede editar ficheros en `Campanas`, pero no crear ni borrar

Esta es la excepcion mas delicada. Hay que usar permisos avanzados.

Configuracion propuesta:

1. Romper herencia en `Comercial\Campanas`.
2. Mantener `Administrators` y `SYSTEM`.
3. Agregar `DL_Campanas_EditSinBorrar`.
4. En permisos avanzados:
   - permitir lectura y escritura sobre archivos existentes
   - denegar `Eliminar`
   - denegar `Eliminar subcarpetas y archivos`
   - denegar `Crear archivos / escribir datos`
   - denegar `Crear carpetas / anexar datos`

Resultado:

- pueden abrir y guardar cambios en archivos existentes
- no pueden crear nuevos archivos
- no pueden borrar

##### d) Solo administradores y Servicio Tecnico modifican `Software`

1. Romper herencia en `ServicioTecnico\Software`.
2. Dejar `Administrators`, `SYSTEM` y `DL_ST_Software_RW`.
3. Asignar `Modificar`.
4. No dar permisos a `GG_Empleados` ni a otros departamentos.

### 3) Misma estructura en ServidorUbuntu por CLI

#### Nota tecnica importante

En Samba AD, la practica mas comoda para ACL complejas es administrarlas desde RSAT. Si el enunciado pide CLI, la forma coherente con el temario es:

1. crear grupos con `samba-tool`
2. compartir recursos por `smb.conf`
3. aplicar ACL en el sistema de ficheros con `setfacl`
4. validar con `samba-tool ntacl get` y `getfacl`

#### Crear grupos si faltan

```bash
samba-tool group add GG_RRHH --group-scope=Global --group-type=Security --description="Departamento RRHH"
samba-tool group add GG_ServicioTecnico --group-scope=Global --group-type=Security --description="Departamento Servicio Tecnico"
samba-tool group add GG_Resp_RRHH --group-scope=Global --group-type=Security --description="Responsables RRHH"
samba-tool group add GG_Resp_ServicioTecnico --group-scope=Global --group-type=Security --description="Responsables Servicio Tecnico"
```

#### Compartir `Datos`

```ini
[Datos]
path = /media/Datos
read only = No
```

#### Preparar la raiz

```bash
sudo chown root:"Domain Admins" /media/Datos
sudo chmod 2770 /media/Datos
sudo setfacl -bR /media/Datos
sudo setfacl -m g:"Domain Admins":rwx /media/Datos
sudo setfacl -d -m g:"Domain Admins":rwx /media/Datos
```

Explicacion detallada de cada comando:

- `sudo chown root:"Domain Admins" /media/Datos`
  Cambia el propietario y el grupo de la carpeta raiz `Datos`.
  El propietario pasa a ser `root`, lo que evita que un usuario normal pueda adueñarse del recurso principal.
  El grupo propietario pasa a ser `Domain Admins`, de forma que los administradores del dominio quedan asociados al recurso desde el principio.

- `sudo chmod 2770 /media/Datos`
  Aplica permisos basicos de Unix sobre la carpeta:
  `2` activa el bit `setgid`, que hace que las subcarpetas y archivos nuevos hereden el grupo de la carpeta padre en lugar del grupo primario del usuario que los crea.
  `770` significa:
  - el propietario tiene `rwx`
  - el grupo tiene `rwx`
  - otros usuarios no tienen ningun permiso
  Esto encaja con la idea de "denegado por defecto".

- `sudo setfacl -bR /media/Datos`
  Borra todas las ACL extendidas que hubiera dentro de `Datos`, de forma recursiva.
  Se usa para partir de una situacion limpia y evitar que queden permisos heredados o pruebas antiguas que contradigan la politica nueva.
  Conviene ejecutarlo antes de empezar a reconstruir los permisos.

- `sudo setfacl -m g:"Domain Admins":rwx /media/Datos`
  Añade una ACL explicita al grupo `Domain Admins` sobre la carpeta actual.
  Con `rwx`, los administradores del dominio pueden entrar, listar, crear, modificar y borrar contenido dentro de `Datos`.
  Este permiso afecta a la carpeta actual aunque no garantiza por si solo la herencia a objetos futuros.

- `sudo setfacl -d -m g:"Domain Admins":rwx /media/Datos`
  Añade una **ACL por defecto** para el grupo `Domain Admins`.
  La opcion `-d` indica que no se esta configurando solo la carpeta actual, sino la plantilla de permisos que heredaran los nuevos archivos y subdirectorios creados dentro de `Datos`.
  Gracias a esto, cuando se cree una carpeta nueva dentro de `Datos`, los administradores del dominio seguiran conservando acceso `rwx` sin tener que reconfigurarlo manualmente.

Idea general del bloque:

- `chown` define propietario y grupo base del recurso.
- `chmod 2770` establece el cierre por defecto y fuerza herencia de grupo con `setgid`.
- `setfacl -bR` limpia ACL anteriores.
- `setfacl -m` crea el permiso efectivo actual.
- `setfacl -d -m` prepara la herencia de ese permiso para el futuro.

#### Permisos departamentales

Cada departamento lee su carpeta y sus responsables escriben:

```bash
sudo setfacl -m g:GG_RRHH:r-x /media/Datos/RRHH
sudo setfacl -m g:GG_Resp_RRHH:rwx /media/Datos/RRHH
sudo setfacl -d -m g:GG_RRHH:r-x /media/Datos/RRHH
sudo setfacl -d -m g:GG_Resp_RRHH:rwx /media/Datos/RRHH

sudo setfacl -m g:GG_Comercial:r-x /media/Datos/Comercial
sudo setfacl -m g:GG_Resp_Comercial:rwx /media/Datos/Comercial
sudo setfacl -d -m g:GG_Comercial:r-x /media/Datos/Comercial
sudo setfacl -d -m g:GG_Resp_Comercial:rwx /media/Datos/Comercial
```

Explicacion detallada del bloque:

La idea de estos comandos es separar claramente dos niveles de acceso dentro de cada departamento:

- los miembros normales del departamento pueden **entrar y leer**
- los responsables del departamento pueden **entrar, leer y escribir**

Ademas, se configura tanto el permiso actual de la carpeta como el permiso por defecto que heredaran los nuevos objetos creados dentro de ella.

#### Parte de RRHH

- `sudo setfacl -m g:GG_RRHH:r-x /media/Datos/RRHH`
  Da al grupo `GG_RRHH` permiso de lectura y acceso a la carpeta `RRHH`.
  `r-x` significa:
  - `r`: pueden leer el contenido y listar archivos
  - `x`: pueden atravesar la carpeta, es decir, entrar en ella
  - no aparece `w`, asi que no pueden modificar, crear ni borrar
  Este comando afecta a la carpeta actual.

- `sudo setfacl -m g:GG_Resp_RRHH:rwx /media/Datos/RRHH`
  Da al grupo de responsables `GG_Resp_RRHH` permiso completo sobre esa carpeta.
  `rwx` significa:
  - leer
  - entrar en la carpeta
  - escribir, crear, renombrar y borrar segun el resto de permisos efectivos del sistema
  Con esto los responsables de RRHH tienen mas privilegios que el resto del departamento.

- `sudo setfacl -d -m g:GG_RRHH:r-x /media/Datos/RRHH`
  Define una ACL **por defecto** para futuros archivos y subcarpetas que se creen dentro de `RRHH`.
  Esto hace que, cuando aparezca contenido nuevo dentro de esa carpeta, el grupo `GG_RRHH` siga teniendo acceso de lectura sin tener que reconfigurarlo manualmente cada vez.

- `sudo setfacl -d -m g:GG_Resp_RRHH:rwx /media/Datos/RRHH`
  Define la ACL por defecto para `GG_Resp_RRHH`.
  Gracias a esto, los responsables seguiran teniendo permiso de escritura tambien sobre el contenido nuevo que se vaya creando dentro de `RRHH`.

#### Parte de Comercial

La misma logica se repite para el departamento Comercial:

- `sudo setfacl -m g:GG_Comercial:r-x /media/Datos/Comercial`
  Los trabajadores de Comercial pueden leer y entrar en su carpeta, pero no modificar.

- `sudo setfacl -m g:GG_Resp_Comercial:rwx /media/Datos/Comercial`
  Los responsables de Comercial pueden leer, entrar y escribir.

- `sudo setfacl -d -m g:GG_Comercial:r-x /media/Datos/Comercial`
  Los objetos nuevos heredaran permiso de lectura para el grupo general del departamento.

- `sudo setfacl -d -m g:GG_Resp_Comercial:rwx /media/Datos/Comercial`
  Los objetos nuevos heredaran permiso de escritura para los responsables.

#### Diferencia entre `-m` y `-d -m`

- `-m` modifica la ACL **actual** de la carpeta existente.
- `-d -m` modifica la ACL **por defecto**, es decir, la plantilla que heredaran archivos y subcarpetas nuevas.

Si se pusiera solo `-m`:

- la carpeta actual quedaria bien configurada
- pero los archivos nuevos podrian no conservar esa misma politica

Si se pusiera solo `-d -m`:

- la herencia futura estaria bien
- pero la carpeta actual podria no tener todavia los permisos correctos

Por eso en la practica se suelen usar ambas formas juntas.

#### Por que se usa `r-x` para el departamento y `rwx` para responsables

Esta decision responde al principio de **minimo privilegio**:

- un empleado normal solo necesita consultar la documentacion de su departamento
- un responsable necesita ademas actualizarla, corregirla o anadir contenido

Asi se evita que todos los miembros del departamento puedan modificar informacion sensible sin necesidad.

#### Resultado practico esperado

En `RRHH` y `Comercial` ocurrira esto:

- un usuario miembro de `GG_RRHH` o `GG_Comercial` podra abrir y leer archivos
- no podra crear ficheros ni borrar documentos
- un usuario miembro de `GG_Resp_RRHH` o `GG_Resp_Comercial` si podra crear, editar y borrar
- los nuevos archivos y carpetas mantendran esta misma politica gracias a las ACL por defecto

#### Ocultar `Software` y `Documentacion` a quien no sea Servicio Tecnico

```bash
sudo chmod 2770 /media/Datos/ServicioTecnico/Software
sudo chmod 2770 /media/Datos/ServicioTecnico/Documentacion
sudo setfacl -b /media/Datos/ServicioTecnico/Software
sudo setfacl -b /media/Datos/ServicioTecnico/Documentacion
sudo setfacl -m g:GG_ServicioTecnico:rwx /media/Datos/ServicioTecnico/Software
sudo setfacl -m g:GG_ServicioTecnico:rwx /media/Datos/ServicioTecnico/Documentacion
sudo setfacl -m g:"Domain Admins":rwx /media/Datos/ServicioTecnico/Software
sudo setfacl -m g:"Domain Admins":rwx /media/Datos/ServicioTecnico/Documentacion
```

Validacion:

```bash
getfacl /media/Datos/RRHH
getfacl /media/Datos/ServicioTecnico/Software
samba-tool ntacl get /media/Datos/RRHH
samba-tool ntacl get /media/Datos/ServicioTecnico/Software
```

### 4) Cuota de 500 MB en `Perfiles` en ServidorWindows

La forma mas coherente es usar `FSRM` con **cuota automatica** sobre `C:\Perfiles`, de manera que cada subcarpeta de perfil reciba su propio limite.

Pasos:

1. Instalar el rol `Administrador de recursos del servidor de archivos`.
2. Abrir `FSRM -> Administracion de cuotas`.
3. Crear una plantilla nueva:
   - nombre: `Perfiles_500MB_Hard`
   - limite: `500 MB`
   - tipo: `Hard quota`
4. Umbral `80%`:
   - accion: enviar correo al administrador
5. Umbral `100%`:
   - accion: enviar correo al usuario propietario de la cuota
6. Crear una `Auto apply template and create quotas on existing and new subfolders`.
7. Ruta: `C:\Perfiles`

Configuracion de correo:

- antes de crear notificaciones, configurar `FSRM Options -> E-mail Notifications`
- indicar servidor SMTP y remitente

Resultado esperado:

- cada subcarpeta de perfil queda limitada a 500 MB
- al 80% se avisa al administrador
- al 100% se bloquea el crecimiento y se avisa al usuario

### 5) Cuota en `Perfiles` en ServidorUbuntu

#### Nota tecnica importante

Con cuotas clasicas de Linux, la cuota no se aplica a una carpeta arbitraria como en FSRM, sino a usuarios o grupos dentro de un sistema de ficheros.

La forma correcta de resolver la practica es:

1. montar `Perfiles` en un volumen dedicado, por ejemplo `/media/Perfiles`
2. hacer que cada subcarpeta de perfil pertenezca a su usuario
3. aplicar cuota de usuario sobre ese volumen

#### Activar cuotas

Instalar paquetes:

```bash
sudo apt update
sudo apt install quota quotatool -y
```

En `/etc/fstab`, montar el volumen de perfiles con `usrquota`:

```fstab
/dev/sdb2 /media/Perfiles ext4 defaults,usrquota 0 0
```

Aplicar cambios:

```bash
sudo mount -o remount,rw /media/Perfiles
sudo quotacheck -cgu /media/Perfiles
sudo quotaon /media/Perfiles
```

#### Asignar propiedad de perfiles

```bash
sudo chown -R usuario1:"domain users" /media/Perfiles/usuario1
sudo chown -R usuario2:"domain users" /media/Perfiles/usuario2
```

#### Configurar cuota 500 MB soft, 700 MB hard

Si tu herramienta trabaja en bloques de 1 KiB:

- `500 MB` = `512000`
- `700 MB` = `716800`

Opcion guiada del temario:

```bash
sudo edquota -u usuario1
```

Valores a dejar:

```text
soft = 512000
hard = 716800
```

Periodo de gracia de dos semanas:

```bash
sudo edquota -t
```

Establecer:

```text
Block grace time: 14days
```

Comprobacion:

```bash
quota -u usuario1
sudo repquota /media/Perfiles
```

Prueba funcional:

```bash
dd if=/dev/zero of=/media/Perfiles/usuario1/prueba.bin bs=1M count=550
dd if=/dev/zero of=/media/Perfiles/usuario1/prueba2.bin bs=1M count=200
```

Resultado esperado:

- hasta 500 MB: sin aviso
- entre 500 y 700 MB: permitido temporalmente dentro del periodo de gracia
- mas de 700 MB: denegado

### 6) Filtrar audio y video en `Datos` en ServidorWindows

Pasos:

1. Abrir `FSRM -> Administracion del filtrado de archivos`.
2. Crear `File Screen` nuevo.
3. Ruta: `D:\Datos`
4. Elegir una plantilla equivalente a:
   - `Block Audio and Video Files`
5. Si no existe, crear una plantilla personalizada con extensiones como:
   - `*.mp3`
   - `*.wav`
   - `*.flac`
   - `*.mp4`
   - `*.avi`
   - `*.mkv`
   - `*.mov`
6. Aplicar el filtro.

Comprobacion:

- intentar guardar `prueba.mp3` o `video.mp4` dentro de `D:\Datos`
- FSRM debe bloquear la operacion

!!! note

    El filtrado de FSRM funciona por extension. Sirve para gobierno basico del recurso, pero no inspecciona el contenido real del fichero.

---

## Resumen practico de verificacion

Antes de entregar, conviene comprobar lo siguiente:

1. Un usuario de cada departamento puede leer solo su carpeta.
2. Un responsable de departamento puede escribir en su carpeta.
3. Un usuario de Gerencia puede leer toda `Datos`.
4. Un usuario normal puede entrar en `Asistencia`, pero no en `Software`.
5. Un usuario de Administracion puede editar un archivo ya existente en `Campanas`, pero no crear uno nuevo ni borrarlo.
6. Un usuario cualquiera puede escribir en `Pruebas`.
7. Las cuotas disparan avisos y bloquean correctamente el crecimiento.
8. El filtro de FSRM impide guardar audio y video.

## Observaciones

- En Windows, la combinacion mas estable es: compartido sencillo + control real por NTFS.
- En Ubuntu, para ACL complejas de Samba, la gestion grafica remota con RSAT suele ser mas comoda; aun asi, esta solucion mantiene la parte CLI que pide el enunciado.
- La actividad de cuotas en Ubuntu solo es rigurosa si `Perfiles` esta en un volumen propio.
