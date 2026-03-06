---
search:
  exclude: true
---

# Explicacion detallada para docente - UD7 (sesion 55 min)

## 1. Como usar este documento en clase

Este documento esta pensado como apoyo rapido para el docente:

1. Si el grupo va bien, usa solo la "respuesta corta".
2. Si hay dudas, usa la "explicacion completa".
3. Si hay debate, usa "justificacion tecnica".
4. Si quieres comprobar comprension, lanza "pregunta de contraste".

Objetivo didactico: que el alumnado no memorice terminos sueltos, sino que entienda por que se organiza AD con grupos, OU y GPO de esta manera.

## 2. Pregunta de control (tramo 2)

### Pregunta
Si cambia una persona de puesto, donde tocamos primero: usuario o grupo?

### Respuesta corta (para clase)
Primero el grupo (membresia), no la ACL del recurso.

### Explicacion completa
Cuando un dominio esta bien disenado, los recursos no conceden permisos a usuarios individuales, sino a grupos de permiso (`DL_*`).
La persona accede porque pertenece a un grupo de rol (`GG_*`) que esta anidado en ese grupo de permiso (`DL_*`).
Si cambia de puesto:

1. Se quita del grupo de rol antiguo.
2. Se anade al grupo de rol nuevo.
3. La ACL del recurso no se toca.

Resultado: menos errores, menos trabajo manual y mas trazabilidad.

### Justificacion tecnica
El modelo separa:

- identidad de la persona (cuenta de usuario)
- rol organizativo (`GG`)
- acceso a recurso (`DL`)
- permiso efectivo (ACL sobre carpeta/app/impresora)

Esa separacion evita el "efecto parche": tocar permisos recurso por recurso cada vez que hay alta, baja o cambio interno.

### Ejemplo real para explicar

Caso:

- Maria estaba en Comercial y pasa a Administracion.
- Antes: `maria -> GG_Comercial -> DL_ERP_RW`.
- Despues: `maria -> GG_Administracion -> DL_Conta_RW`.

No hay que abrir cada recurso para editar permisos manualmente.

### Pregunta de contraste (para verificar comprension)
Si un alumno responde "yo tocaria la carpeta directamente", pregunta:
"Y cuando cambien 20 usuarios, haras 20 cambios de ACL o 20 cambios de grupo?"

## 3. Ticket de salida - Pregunta 1

### Pregunta
Diferencia entre `Grupo` y `OU`.

### Respuesta corta

- Grupo: permisos y derechos.
- OU: organizacion y alcance de GPO.

### Explicacion completa

Para explicarlo bien al alumnado, separa la respuesta en 4 capas:

1. Que es tecnicamente cada objeto.
2. Que problema resuelve cada uno.
3. Que cambia en la practica al administrar.
4. Que NO hace cada uno (para evitar confusiones).

`Grupo` (en UD7 hablamos de grupo de seguridad):

- Es un **principal de seguridad**.
- Tiene **SID propio**.
- Puede aparecer en ACL/DACL de carpetas, impresoras, aplicaciones, etc.
- Puede contener usuarios, equipos u otros grupos (segun ambito/reglas).
- Un usuario puede estar en varios grupos a la vez.
- Su pertenencia afecta al **token de acceso** del usuario/equipo.

`OU`:

- Es un **contenedor organizativo** del directorio.
- No se usa como principal de seguridad para ACL de recursos.
- Se usa para estructurar AD (departamentos, sedes, tipos de equipos).
- Permite delegar administracion por arbol.
- Es el destino natural para vincular GPO.
- Un objeto solo puede estar en una OU concreta a la vez.

Idea clave para repetir en voz alta:
"Grupo controla acceso a recursos; OU controla organizacion y politicas."

### Diferencia funcional (la que de verdad importa en operaciones)

- Si quieres decidir **quien entra a un recurso**: actuas sobre grupos.
- Si quieres decidir **que configuracion recibe un conjunto de objetos**: actuas sobre OU + GPO.

### Diferencia tecnica (nivel admin)

- Grupo de seguridad: participa en evaluacion de permisos (ACL) mediante SID.
- OU: no da ni quita permisos por si misma sobre recursos compartidos.
- GPO: se vincula a Sitio/Dominio/OU; luego se procesa por herencia/precedencia.

### Ejemplo completo de una misma usuaria (muy util en clase)

Usuaria `maria`:

- Ubicada en `OU=Comercial` (para que reciba politicas de ese departamento).
- Miembro de `GG_Comercial` (rol funcional).
- Tambien miembro de `GG_Responsables` (rol transversal).
- Acceso a ERP porque `GG_Comercial` esta anidado en `DL_ERP_RW`.

Que pasa si cambia de departamento:

- Mueves su usuario a otra OU si debe heredar otras GPO.
- Cambias su membresia de grupos para permisos.

Conclusión docente:
En un cambio real de puesto pueden intervenir **ambas cosas**, pero con objetivos distintos:

- OU para politicas/configuracion.
- grupos para accesos/permisos.

### Tabla rapida de decision (para dudas en directo)

- Necesito ocultar panel de control a 30 usuarios: `OU + GPO`.
- Necesito dar acceso a carpeta de Nominas: `Grupo (DL) + ACL`.
- Necesito que solo TIC administre ciertas cuentas: `OU + delegacion`, y grupos para derechos concretos.
- Necesito que una persona tenga dos funciones a la vez: `grupos multiples` (no dos OU).

### Justificacion tecnica
Las GPO no se vinculan a grupos. Se vinculan a Sitio, Dominio u OU.
Por eso, si quieres cambiar configuracion de entorno, debes actuar por OU (y filtros), no tratando la OU como si fuera un grupo de permisos.

### Error tipico y correccion
Error:
"Meto un usuario en grupo X para que reciba la GPO."

Correccion:
La GPO se aplica por ubicacion (OU) y procesamiento de politicas. El grupo puede servir para filtrado de seguridad, pero la vinculacion base sigue siendo al contenedor.

### Error tipico 2 y correccion
Error:
"Si meto una OU en la ACL de la carpeta, ya entra todo el departamento."

Correccion:
No. Las ACL esperan principales de seguridad (usuarios/grupos). Para departamentos se usa un grupo de seguridad, no la OU.

## 4. Ticket de salida - Pregunta 2

### Pregunta
Por que se recomienda `GG -> DL -> permisos`.

### Respuesta corta
Porque desacopla personas y recursos, y eso hace la administracion mantenible.

### Explicacion completa
`GG -> DL -> Permisos` significa:

1. `GG` (Global Group) agrupa cuentas por rol/departamento.
2. `DL` (Domain Local) representa el permiso sobre un recurso concreto.
3. La ACL del recurso se asigna a `DL`, no a usuarios.

Ventajas:

- escalabilidad: funciona igual con 10 o 1000 usuarios
- consistencia: mismo patron en todos los recursos
- auditoria: es facil responder "quien accede y por que"
- mantenimiento: cambios de personal sin rehacer ACL

### Explicacion lista para decir en voz alta

> Yo no doy permisos a cada persona una por una. Primero junto a las personas que hacen la misma funcion en un grupo `GG`. Despues creo un grupo `DL` que representa el permiso sobre un recurso. Luego meto el `GG` dentro del `DL`. El recurso solo da permiso al `DL`. Eso es el anidamiento.

Frase-resumen para fijar:

- `GG` = quienes son
- `DL` = a que recurso acceden

### Ejemplo de pizarra ampliado

```text
maria -> GG_Comercial -> DL_ERP_RW -> ERP
```

Lectura que conviene verbalizar:

1. `maria` pertenece a `GG_Comercial`.
2. `GG_Comercial` esta dentro de `DL_ERP_RW`.
3. El ERP da permiso solo a `DL_ERP_RW`.
4. Maria entra al ERP sin que el ERP tenga un permiso directo para ella.

### Analogia de aula

Puede compararse con una llave de una sala:

- `GG_Comercial` es el conjunto de personas de Comercial
- `DL_ERP_RW` es el grupo que tiene la llave del ERP

No se entrega la llave persona por persona cada vez que cambia la plantilla. Se gestiona la pertenencia al grupo correcto.

### Justificacion tecnica
Un grupo `Global` esta orientado a "quienes son". Un `Domain Local` esta orientado a "a que recurso acceden". Esa separacion encaja con buenas practicas de AD y reduce deuda operativa.

### Ejemplo corto listo para pizarra

- `ana`, `luis`, `maria` en `GG_Comercial`
- `GG_Comercial` dentro de `DL_ERP_RW`
- ERP concede `Modify` solo a `DL_ERP_RW`

Si entra `juan` en Comercial, solo anadir `juan` a `GG_Comercial`.

### Cuando podria variar este modelo
En bosques o entornos multi-dominio complejos puede entrar `UG` (Universal Group). En esta UD de dominio unico, no hace falta salvo requisito claro.

## 5. Ticket de salida - Pregunta 3

### Pregunta
Que comando usan para forzar politicas.

### Respuesta corta
`gpupdate /force`

### Explicacion completa
Las GPO se refrescan periodicamente, pero en clase no interesa esperar. Con `gpupdate /force` fuerzas reevaluacion inmediata de directivas de usuario y equipo.

Despues hay que validar, no suponer:

```powershell
gpresult /r
```

Si quieres una prueba formal mas completa:

```powershell
gpresult /h C:\Temp\gpo.html
```

### Justificacion tecnica
Configurar no es validar. En administracion de sistemas, una politica solo se considera "hecha" cuando su efecto se observa en cliente y se puede demostrar con evidencia.

### Error tipico y correccion
Error:
"La GPO esta creada, asi que ya aplica."

Correccion:
Puede estar mal vinculada, filtrada, bloqueada por herencia o aun no refrescada. Siempre ejecutar validacion.

## 6. Justificaciones frecuentes (respuestas listas)

### 6.1 Por que `Global` para `GG_Comercial`
Porque agrupa cuentas del mismo dominio por identidad funcional (departamento o rol). Es el uso natural del ambito Global.

### 6.2 Por que `Domain Local` para `DL_ERP_RW`
Porque el grupo de ambito local de dominio se usa para recibir permisos directos sobre recursos del dominio donde vive ese recurso.

### 6.3 Por que evitar permisos directos a usuarios
Porque rompe estandar, multiplica cambios manuales y dificulta auditoria. Al cabo de unos meses nadie entiende "por que este usuario tiene acceso".

### 6.4 Por que no usar siempre grupos `Universal`
Porque no aportan valor en un dominio unico sencillo y pueden anadir complejidad innecesaria. Primero resolver con `GG` y `DL`.

### 6.5 Por que no meter todo en `Default Domain Policy`
Porque conviene reservarla para base de seguridad de dominio. Para configuraciones de entorno o casos concretos, crear GPO separadas, con nombre y objetivo claro.

## 7. Respuestas ampliadas para preguntas de alumnado

### "Si somos pocos, no es mas rapido dar permiso directo?"
Puede ser mas rapido hoy, pero no manana. En cuanto hay rotacion, sustituciones o auditoria, ese atajo se vuelve caro. La buena practica se adopta desde el inicio para no rehacer despues.

### "Entonces los grupos no sirven para GPO?"
Sirven de forma indirecta en filtrado de seguridad o WMI, pero la vinculacion principal de la GPO sigue siendo al contenedor (Sitio/Dominio/OU).

### "Por que mi GPO no aplica aunque la cree bien?"
Revisar en orden:

1. Vinculo correcto a OU/Dominio.
2. Objeto (usuario/equipo) realmente dentro de esa OU.
3. Herencia bloqueada o GPO forzada.
4. Filtro de seguridad.
5. `gpupdate /force` y comprobacion con `gpresult /r`.

## 8. Rubrica rapida de evaluacion oral (durante la practica)

Nivel basico:

- identifica diferencia grupo/OU sin mezclar conceptos
- sabe ejecutar `gpupdate /force`

Nivel medio:

- propone estructura `GG` y `DL` coherente
- justifica por que no asigna permisos directos a usuarios

Nivel alto:

- explica anidamiento completo y validacion en cliente con evidencia
- detecta causa probable si una GPO no aplica

## 9. Frases de apoyo para usar literalmente

- "No toques ACL por persona, toca membresia por rol."
- "Grupo = permiso. OU = politica."
- "Si no hay `gpresult`, no hay validacion."
- "Disenar primero evita parches despues."

## 10. Mini guion de cierre (2 minutos)

1. Hoy hemos separado identidad, organizacion y configuracion.
2. Identidad y acceso se gestionan con grupos (`GG -> DL`).
3. Configuracion de entorno se gestiona con OU + GPO.
4. Toda configuracion debe terminar en evidencia de cliente (`gpupdate` + `gpresult`).
5. Con este modelo, el dominio escala sin caos administrativo.
