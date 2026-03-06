---
search:
  exclude: true
---

# Explicacion detallada para docente - UD8 (sesion 55 min)

## 1. Como usar este documento

Este guion esta pensado para una sesion de 55 minutos con enfoque practico.
Usalo en 3 niveles:

1. `respuesta corta`: frase directa para no perder ritmo.
2. `explicacion completa`: desarrollo cuando el grupo pide detalle.
3. `validacion`: prueba rapida para comprobar que no solo memorizan.

Objetivo didactico central: que el alumnado relacione control de acceso, permisos efectivos y gestion de almacenamiento como un unico sistema de administracion, no como temas sueltos.

## 2. Objetivos evaluables de la sesion

Al finalizar la clase, el alumnado debe poder:

1. Diferenciar con precision `derechos/privilegios` frente a `permisos`.
2. Explicar como se decide el acceso: `token de acceso + ACE/ACL`.
3. Justificar por que se recomienda asignar permisos a grupos y no a usuarios individuales.
4. Resolver un caso simple de conflicto entre permisos de recurso compartido y permisos NTFS.
5. Identificar cuando mantener herencia y cuando romperla.
6. Interpretar el resultado de `permisos efectivos` para un usuario concreto.
7. Distinguir y aplicar el sentido operativo de `soft quota` y `hard quota`.
8. Detectar la limitacion del filtrado por extension de archivo.

## 3. Preparacion previa (docente)

### 3.1 Entorno minimo

- Recurso compartido de prueba: `Datos`.
- Subcarpetas de ejemplo: `RRHH`, `Comercial`, `Pruebas`.
- Grupos de ejemplo:
  - `GG_RRHH`, `GG_Comercial`
  - `DL_Datos_R`, `DL_Datos_RW`
- Dos usuarios de prueba:
  - `u_lectura` (solo lectura)
  - `u_edicion` (lectura/escritura)

### 3.2 En Windows Server (GUI)

- Acceso a propiedades del recurso: pestanas `Compartir` y `Seguridad`.
- Ruta preparada para permisos efectivos:
  - `Propiedades -> Seguridad -> Opciones avanzadas -> Acceso efectivo`
- Rol disponible para cuotas/filtro:
  - `Administrador de recursos del servidor de archivos (FSRM)`

### 3.3 En Ubuntu Server (referencia CLI para contraste)

- ACL extendidas activas en el volumen de datos.
- Comandos disponibles:
  - `samba-tool ntacl get /media/datos`
  - `getfacl /media/datos`
- Paquetes de cuota instalados si vas a mostrar CLI:
  - `quota`, `quotatool`

### 3.4 Material de clase

- Diapositiva o pizarra con el flujo:
  - `usuario -> token -> ACE/ACL -> permiso efectivo`
- Mini tabla impresa de decision:
  - "permisos por grupo" vs "permisos directos por usuario"
- Ticket de salida (3 preguntas, 1 minuto).

## 4. Guion minuto a minuto (55 min)

## Tramo 1 (0-5 min) - Apertura y contexto operativo

### Objetivo del tramo

Conectar el tema con problemas reales de administracion.

### Que decir (literal sugerido)

"Hoy no vamos a aprender botones sueltos. Vamos a decidir quien entra, que puede hacer y cuanto puede ocupar en el servidor."

"Si esto se disena mal, el dominio funciona, pero no es mantenible ni auditable."

### Pregunta de activacion

"Si una persona cambia de departamento, que tocamos primero: la ACL de la carpeta o la membresia de grupos?"

### Respuesta esperada

"La membresia de grupos."

### Validacion rapida

- Si responden "carpeta", repregunta:
  - "Con 40 cambios de personal, prefieres tocar 40 ACL o 40 membresias?"

## Tramo 2 (5-12 min) - Marco conceptual sin ambiguedades

### Objetivo del tramo

Separar conceptos que suelen mezclarse: derecho, privilegio, permiso, ACL, ACE, token.

### Mensajes clave

1. El usuario inicia sesion y recibe un `token de acceso`.
2. El sistema compara ese token con las `ACE` del objeto.
3. El conjunto de ACE forma la `ACL`.
4. Sin regla que permita explicitamente, la accion se deniega.
5. `Derechos/privilegios` se aplican a cuentas; `permisos` se aplican a objetos.

### Que decir (literal sugerido)

"No hay acceso por intuicion, solo por coincidencia entre identidad y reglas."

"Privilegio no es lo mismo que permiso: uno describe capacidades de cuenta en el sistema; el otro describe acciones sobre un recurso."

### Micro ejemplo para fijar idea

- Caso: usuario miembro de `Operadores de copia`.
- Aunque un fichero tenga restricciones, un derecho de copia/backup puede alterar el resultado operativo del acceso.
- Mensaje docente: "por eso hay que revisar permisos y privilegios, no solo una pestaña."

### Pregunta de control

"Que diferencia hay entre dar un privilegio y dar un permiso?"

### Respuesta esperada

"El privilegio actua sobre capacidades de cuenta en el sistema; el permiso sobre un objeto concreto."

## Tramo 3 (12-23 min) - Demo guiada 1: recurso compartido + NTFS

### Objetivo del tramo

Demostrar que el acceso final en red combina permisos de compartido y NTFS, aplicando el criterio mas restrictivo.

### Secuencia docente (paso a paso)

1. Abrir carpeta `Datos` y mostrar:
   - pestana `Compartir`
   - pestana `Seguridad`
2. Explicar independencia de ambos sistemas de permisos.
3. Aplicar estrategia recomendada de la unidad:
   - simplificar permisos de compartido
   - administrar de verdad en NTFS por grupos
4. Asignar NTFS a grupos (`DL_*`), no a usuarios individuales.
5. Probar con `u_lectura` y `u_edicion`.

### Que decir mientras ejecutas

"El compartido abre la puerta de red; NTFS decide lo que ocurre dentro."

"Si hay contradiccion, gana la restriccion."

"La ACL debe hablar de roles, no de personas."

### Observacion esperada

- `u_lectura` abre y consulta, pero no modifica.
- `u_edicion` crea/modifica segun el permiso previsto.

### Error tipico a provocar y corregir

- Error: permiso directo a usuario para "arreglar rapido".
- Correccion: quitar permiso directo y resolver via grupo.
- Mensaje: "atajo hoy, deuda tecnica manana."

## Tramo 4 (23-31 min) - Derechos, privilegios y propietario

### Objetivo del tramo

Evitar el error de pensar que "todo se resuelve en NTFS".

### Secuencia docente

1. Recordar que derechos/privilegios se asignan:
   - por grupos incorporados (`Builtin`)
   - o por directiva:
     - `Administracion de directivas de grupo`
     - `Default Domain Controllers Policy`
     - `Configuracion de equipo -> Directivas -> Configuracion de Windows -> Configuracion de seguridad -> Directivas locales -> Asignacion de derechos de usuario`
2. Mostrar concepto de propietario:
   - el propietario puede cambiar permisos del objeto.
3. Ruta de propiedad en GUI:
   - `Propiedades -> Seguridad -> Opciones avanzadas -> Cambiar`

### Que decir (literal sugerido)

"Permiso denegado no siempre significa ACL mal hecha. Puede haber un privilegio o una propiedad implicada."

"Por eso en soporte real, diagnosticar es revisar capas, no solo una pestana."

### Pregunta de control

"Que hereda un usuario al entrar en un grupo Builtin?"

### Respuesta esperada

"Los privilegios asociados a ese grupo."

## Tramo 5 (31-40 min) - Demo guiada 2: herencia y permisos efectivos

### Objetivo del tramo

Explicar por que una subcarpeta puede comportarse distinto sin "errores aparentes".

### Secuencia docente

1. Crear subcarpeta en `Datos` (ejemplo: `Datos/RRHH/Confidencial`).
2. Mostrar permisos heredados.
3. Deshabilitar herencia.
4. Elegir una de dos opciones y explicar impacto:
   - convertir heredados en explicitos
   - eliminar heredados
5. Consultar `Acceso efectivo` para un usuario real.

### Que decir (literal sugerido)

"La herencia es la norma. Romperla es una excepcion justificada."

"Configurar no es validar. Validar es calcular acceso efectivo."

### Advertencia importante de la unidad

La consulta de permisos efectivos puede salir incoherente si:

- las herramientas administrativas se ejecutan en remoto,
- o la cuenta usada para revisar no esta en el mismo dominio del recurso.

Mensaje docente: "si el resultado no cuadra, primero verifica contexto de ejecucion."

### Error tipico a corregir

- Error: "estoy en el grupo, por tanto debo poder escribir".
- Correccion: comprobar denegaciones, herencia y resultado efectivo real.

## Tramo 6 (40-49 min) - Demo guiada 3: cuotas y filtrado

### Objetivo del tramo

Conectar seguridad con explotacion diaria del servidor.

### Secuencia docente (Windows)

1. Abrir `FSRM -> Administracion de cuotas`.
2. Crear cuota en recurso objetivo (ejemplo didactico: 500 MB hard).
3. Crear umbral de aviso (80%) y aviso de maximo (100%).
4. Mostrar `Administracion del filtrado de archivos`.
5. Aplicar plantilla para bloquear audio/video.

### Mensajes clave

- Cuota `hard`: no se puede superar.
- Cuota `soft`: permite rebasar temporalmente segun periodo de gracia.
- El filtrado por extension ayuda, pero no inspecciona contenido real.

### Que decir (literal sugerido)

"La cuota no solo limita, tambien educa uso responsable del almacenamiento."

"Cambiar extension puede burlar filtros simples; por eso no es una medida unica de seguridad."

### Contraste CLI (si procede, 2 minutos maximos)

```bash
sudo quotacheck -cgu /media/Datos
sudo edquota -u administrador
sudo repquota /dev/sdb1
```

## Tramo 7 (49-53 min) - Practica express por parejas

### Objetivo del tramo

Pasar de "entiendo la teoria" a "se disenar y justificar".

### Reto (4 minutos)

Cada pareja entrega en una hoja:

1. 2 carpetas de ejemplo y grupos con permisos `R` y `RW`.
2. 1 caso donde romperia herencia y por que.
3. 1 cuota propuesta (hard y aviso).
4. 1 riesgo del filtrado por extension.

### Evidencia minima esperada

- Esquema con grupos, no usuarios individuales.
- Justificacion tecnica breve (2-3 lineas).

## Tramo 8 (53-55 min) - Cierre y ticket de salida

### Ticket (1 minuto)

1. Diferencia entre `privilegio` y `permiso`.
2. Regla practica para administrar carpetas compartidas.
3. Primeras 2 comprobaciones si un usuario "deberia entrar y no entra".

### Plantilla de correccion rapida

1. Privilegio: capacidad de cuenta en el sistema. Permiso: accion sobre objeto.
2. Permisos por grupos (NTFS) y evitar permisos directos a usuarios.
3. Revisar membresia de grupos + permiso efectivo/herencia (y conflicto compartido/NTFS).

## 5. Preguntas de contraste para consolidar

### Pregunta 1

"Si pongo 'Control total' en el compartido a Todos, estoy abriendo todo sin control?"

Respuesta docente:

"No, si el control real lo estas aplicando en NTFS con grupos. El acceso final sigue limitado por el permiso mas restrictivo."

### Pregunta 2

"Cuando merece la pena romper herencia?"

Respuesta docente:

"Cuando hay excepcion real de seguridad o privacidad. Si no, mantener herencia reduce errores."

### Pregunta 3

"Por que no dar permisos directos a usuarios si somos pocos?"

Respuesta docente:

"Porque escala mal, complica auditoria y dificulta cambios de personal."

### Pregunta 4

"El filtrado de archivos evita siempre meter videos?"

Respuesta docente:

"No siempre. Si solo filtras por extension, puede haber evasiones."

## 6. Rubrica oral rapida (durante la sesion)

Nivel basico:

- diferencia privilegio vs permiso
- entiende el papel de herencia

Nivel medio:

- disena permisos por grupos coherentes
- interpreta un conflicto entre compartido y NTFS

Nivel alto:

- justifica romper herencia con criterio tecnico
- valida acceso con permisos efectivos y propone cuota razonada

## 7. Checklist docente de verificacion

Antes de clase:

- recurso `Datos` accesible
- usuarios y grupos de prueba creados
- FSRM disponible

Durante clase:

- se prueba con cuentas reales, no solo con admin
- se provoca al menos 1 error tipico y se corrige en directo
- se verifica acceso efectivo antes de cerrar

Despues de clase:

- recoger ticket de salida
- anotar dudas repetidas para abrir siguiente sesion

## 8. Comandos y rutas de apoyo (chuleta)

### Windows (GUI)

- Permisos efectivos:
  - `Propiedades -> Seguridad -> Opciones avanzadas -> Acceso efectivo`
- Cambiar propietario:
  - `Propiedades -> Seguridad -> Opciones avanzadas -> Cambiar`
- Derechos de usuario (GPO):
  - `Default Domain Controllers Policy -> ... -> Asignacion de derechos de usuario`
- Cuotas y filtrado:
  - `FSRM -> Administracion de cuotas / Administracion de filtrado de archivos`

### Ubuntu (CLI de referencia)

```bash
# ACL y permisos
samba-tool ntacl get /media/datos
getfacl /media/datos

# Cuotas
sudo apt-get install quota quotatool
sudo mount -o remount,rw /media/Datos
sudo quotacheck -cgu /media/Datos
sudo edquota -u administrador
sudo edquota -t
sudo repquota /dev/sdb1
```

## 9. Frases cortas para usar literalmente

- "Permisos a grupos; personas cambian, roles permanecen."
- "Configurar no es validar: mide acceso efectivo."
- "Herencia por defecto; excepcion solo con justificacion."
- "Cuotas y filtros son gobierno del recurso, no castigo."

## 10. Explicacion continua para lectura

En esta unidad el objetivo no es aprender menus de memoria, sino entender como decide un sistema si un usuario puede acceder o no a un recurso.
Cuando una persona inicia sesion en el dominio, el sistema construye un token de acceso con su identidad y sus grupos.
Al intentar entrar a una carpeta o abrir un archivo, ese token se compara con las entradas ACE del objeto.
La suma de esas entradas forma la ACL.
Si no existe una regla que permita la accion solicitada, el acceso se deniega.
Esta idea es la base de todo el tema.

Un error muy habitual del alumnado es mezclar privilegios con permisos.
En clase hay que insistir en que un privilegio afecta a lo que una cuenta puede hacer en el sistema, mientras que un permiso afecta a lo que esa cuenta puede hacer sobre un objeto concreto.
Por eso no basta con mirar la pestana de Seguridad de una carpeta: a veces tambien intervienen derechos de usuario, pertenencia a grupos Builtin o propiedad del objeto.
Si no se separan estas capas, el diagnostico de incidencias termina en prueba y error.

En recursos compartidos de Windows hay dos planos que conviven: permisos del recurso compartido y permisos NTFS.
Ambos son independientes y el resultado final se calcula de forma conjunta.
Si se contradicen, se aplica la opcion mas restrictiva.
La practica recomendada de la unidad es simplificar el compartido y administrar con detalle en NTFS, siempre por grupos.
Esto permite que los cambios de personal se resuelvan modificando membresias, sin tocar ACL recurso por recurso.
En terminos de mantenimiento y auditoria, esta diferencia es critica.

La herencia de permisos debe presentarse como mecanismo de coherencia.
Por defecto, las subcarpetas y archivos heredan del contenedor.
Eso reduce trabajo y evita incoherencias.
Romper herencia solo tiene sentido cuando existe una necesidad real de excepcion, por ejemplo privacidad de RRHH o separacion de funciones.
Al deshabilitar herencia, hay que decidir si convertir permisos heredados en explicitos o eliminarlos.
Esa decision cambia por completo el resultado final y debe justificarse, no improvisarse.

Despues de configurar, hay que validar.
La validacion se hace con Acceso efectivo y con usuarios de prueba reales.
Si el resultado no cuadra, se revisa en este orden: membresia de grupos, herencia, permisos NTFS, permisos del compartido y posibles privilegios implicados.
Tambien hay que recordar que la consulta de permisos efectivos puede mostrar resultados confusos cuando se administra en remoto o con cuentas fuera del dominio del recurso.
Diagnosticar bien significa comprobar contexto, no solo repetir clics.

La segunda mitad de la unidad conecta seguridad con operacion del servidor: cuotas y filtrado.
Las cuotas controlan crecimiento y ayudan a evitar saturacion del almacenamiento.
Una cuota hard no se puede superar; una cuota soft permite rebasar temporalmente segun el periodo de gracia.
En Windows esto se trabaja con FSRM y sus umbrales de notificacion, por ejemplo aviso al 80% y al 100%.
En Ubuntu se puede contrastar por CLI con quotacheck, edquota y repquota.
Lo importante es que el alumnado entienda el criterio de administracion, no solo el comando.

El filtrado de archivos por extension es util para gobierno basico del recurso compartido, por ejemplo bloquear audio y video en carpetas de trabajo.
Pero no debe venderse como control infalible: un usuario puede cambiar extensiones y burlar filtros simples.
La conclusion didactica es clara: filtrado por extension es una medida de apoyo, no una solucion total de seguridad.

Si el grupo se queda con una sola idea al cerrar la clase, debe ser esta:
el acceso estable en un dominio se construye con diseno por grupos, herencia bien usada, validacion por permisos efectivos y control de capacidad con cuotas.
Configurar sin validar genera incidencias; disenar y validar reduce incidencias.

## 11. Respuestas desarrolladas a las preguntas del guion

### 11.1 Pregunta de activacion (Tramo 1)

Pregunta:
"Si una persona cambia de departamento, que tocamos primero: la ACL de la carpeta o la membresia de grupos?"

Respuesta recomendada:
Se toca primero la membresia de grupos.
En un diseno correcto, las ACL se asignan a grupos de permiso (`DL_*`) y no a usuarios individuales.
Cuando una persona cambia de puesto, se actualiza su grupo de rol (`GG_*`) y el acceso se ajusta sin rehacer permisos carpeta por carpeta.
Esto reduce errores y mantiene trazabilidad.

### 11.2 Pregunta de control (Tramo 2)

Pregunta:
"Que diferencia hay entre dar un privilegio y dar un permiso?"

Respuesta recomendada:
Un privilegio define capacidades de la cuenta en el sistema (por ejemplo, copia de seguridad o inicio de sesion en cierto modo).
Un permiso define acciones sobre un objeto concreto (leer, escribir, modificar, etcetera).
Los privilegios se gestionan en cuentas/grupos y directivas; los permisos se gestionan en ACL del recurso.

### 11.3 Pregunta de control (Tramo 4)

Pregunta:
"Que hereda un usuario al entrar en un grupo Builtin?"

Respuesta recomendada:
Hereda los derechos y privilegios que ese grupo tenga asignados por defecto o por politica.
No hereda automaticamente permisos sobre todos los recursos: esos dependen de la ACL de cada objeto.
Por eso conviene explicar que "privilegios de cuenta" y "permisos de objeto" son capas diferentes.

### 11.4 Ticket de salida - Pregunta 1

Pregunta:
"Diferencia entre privilegio y permiso."

Respuesta ampliada:
El privilegio es una capacidad de la cuenta en el sistema operativo o dominio.
El permiso es una autorizacion sobre un recurso concreto.
Ejemplo: un usuario puede tener privilegio de copia de seguridad pero no permiso de escritura en una carpeta concreta.

### 11.5 Ticket de salida - Pregunta 2

Pregunta:
"Regla practica para administrar carpetas compartidas."

Respuesta ampliada:
Asignar permisos a grupos, no a usuarios.
En compartidos de Windows, simplificar permisos de compartido y administrar detalle en NTFS.
Validar siempre con cuentas reales y acceso efectivo.

### 11.6 Ticket de salida - Pregunta 3

Pregunta:
"Primeras 2 comprobaciones si un usuario deberia entrar y no entra."

Respuesta ampliada:
Primero revisar membresia de grupos y token esperado del usuario.
Segundo revisar herencia y permisos efectivos en el recurso.
Despues, si persiste, revisar conflicto entre permisos de compartido y NTFS, y posibles privilegios/propiedad del objeto.

### 11.7 Pregunta de contraste 1

Pregunta:
"Si pongo Control total en el compartido a Todos, estoy abriendo todo sin control?"

Respuesta ampliada:
No necesariamente.
Si el control real esta en NTFS por grupos, el resultado final sigue limitado.
El acceso efectivo combina ambos planos y aplica el criterio mas restrictivo.
La clave es no dejar NTFS abierto en exceso.

### 11.8 Pregunta de contraste 2

Pregunta:
"Cuando merece la pena romper herencia?"

Respuesta ampliada:
Cuando hay una excepcion real de seguridad o privacidad (por ejemplo, subcarpetas confidenciales).
Si no hay excepcion clara, mantener herencia es mejor porque reduce configuraciones manuales y errores.
Romper herencia sin criterio suele crear incidencias dificiles de auditar.

### 11.9 Pregunta de contraste 3

Pregunta:
"Por que no dar permisos directos a usuarios si somos pocos?"

Respuesta ampliada:
Porque el coste aparece con el tiempo: rotaciones, sustituciones y auditorias.
El modelo por grupos desacopla personas de recursos.
Con ese modelo, un cambio de persona es un cambio de membresia, no una reconstruccion de ACL.

### 11.10 Pregunta de contraste 4

Pregunta:
"El filtrado de archivos evita siempre meter videos?"

Respuesta ampliada:
No.
El filtrado basico por extension es util, pero no infalible.
Si alguien cambia la extension, puede intentar evadir el filtro.
Es una medida de gobierno del recurso, no una solucion total de seguridad.

## 12. Teoria ampliada de la UD8

### 12.1 Modelo de autorizacion en Active Directory

El control de acceso en AD se basa en la evaluacion de identidad contra reglas.
La identidad llega en forma de token de acceso.
Las reglas viven en ACE dentro de una ACL en cada objeto.
La decision final es una evaluacion de capas:

1. Quien es el usuario y a que grupos pertenece.
2. Que permisos tiene el objeto.
3. Que privilegios de cuenta estan implicados.
4. Si hay herencia, denegaciones o propiedad que alteren el resultado.

Conclusiones practicas:

- El acceso no se "supone", se calcula.
- Sin validacion de acceso efectivo, no hay certeza de configuracion.

### 12.2 ACL, ACE y permiso efectivo

Una ACL es la lista de reglas de seguridad de un objeto.
Cada regla individual es una ACE.
Al evaluar un acceso, el sistema cruza ACE con el token del usuario.
Por eso dos usuarios sobre la misma carpeta pueden tener resultados distintos.

Permiso efectivo no es "lo que pone en una linea", sino el resultado real tras combinar:

- membresia en grupos globales/locales/universales,
- permisos de compartido y NTFS,
- privilegios de usuario,
- herencia y permisos explicitos.

### 12.3 Derechos y privilegios frente a permisos

Derechos/privilegios:

- se aplican a cuentas y grupos,
- habilitan acciones del sistema (inicio, copia, administracion),
- suelen gestionarse por grupos Builtin o GPO.

Permisos:

- se aplican a objetos (carpetas, ficheros, etcetera),
- determinan acciones permitidas sobre ese objeto,
- se expresan en ACL y deben asignarse por grupos de rol/acceso.

Relacion didactica clave:

- privilegio responde "que puede hacer la cuenta en el sistema",
- permiso responde "que puede hacer la cuenta en este recurso".

### 12.4 Diseno recomendado de permisos

Patron recomendado para la unidad:

1. Agrupar personas por rol funcional (`GG_*`).
2. Crear grupos de acceso por recurso (`DL_*`).
3. Asignar ACL al grupo de acceso (`DL_*`), no al usuario.
4. Cambiar membresias ante altas/bajas/cambios de puesto.

Beneficios:

- menor esfuerzo de mantenimiento,
- menos errores manuales,
- mejor auditoria y explicabilidad.

### 12.5 Compartido y NTFS en recursos de red

En carpetas compartidas intervienen dos planos:

- permisos del recurso compartido (acceso por red),
- permisos NTFS (acciones dentro del recurso).

Son independientes y se combinan.
Si hay conflicto, prevalece la restriccion.
Por eso en operacion se recomienda simplificar compartido y controlar en NTFS.

### 12.6 Herencia: cuando mantener y cuando romper

Heredar permisos permite consistencia en arboles de carpetas.
Reduce configuraciones repetidas y evita divergencias entre subcarpetas.
Romper herencia solo debe hacerse con criterio tecnico:

- necesidad de privacidad real,
- separacion de funciones,
- requisito normativo o de auditoria.

Si se rompe, decidir conscientemente entre:

- convertir heredados en explicitos,
- eliminar heredados y reconstruir ACL minima.

### 12.7 Propiedad del objeto y su impacto

El propietario de un objeto tiene capacidad de cambiar su seguridad.
Esto explica casos donde el comportamiento no coincide con una lectura superficial de permisos.
Buena practica docente:

- evitar que objetos criticos queden con propiedad dispersa en usuarios finales,
- centralizar en cuentas/grupos administrativos cuando proceda.

### 12.8 Cuotas de disco: control operativo del recurso

Las cuotas no son solo limite tecnico.
Tambien son politica de uso del almacenamiento.
Permiten:

- evitar saturacion del volumen,
- priorizar espacio para informacion de trabajo,
- establecer alertas antes del agotamiento.

Diferencias clave:

- `hard quota`: limite no superable.
- `soft quota`: limite flexible temporal con periodo de gracia.

### 12.9 Filtrado de archivos: alcance real

El filtrado por extension sirve para reducir tipos de archivo no deseados.
Es util para gobierno basico de carpetas compartidas.
Limitacion:

- no valida contenido real del fichero,
- puede ser evadido con cambios de extension.

Conclusion operativa:

- usarlo como medida complementaria,
- no presentarlo como mecanismo unico de seguridad.

### 12.10 Validacion y evidencia tecnica

En administracion de sistemas, "configurado" no significa "correcto".
La secuencia profesional es:

1. Disenar.
2. Configurar.
3. Probar con usuarios reales.
4. Verificar permiso efectivo.
5. Documentar evidencia.

Esta secuencia conecta directamente con las actividades de la UD8 y con la evaluacion del modulo.
