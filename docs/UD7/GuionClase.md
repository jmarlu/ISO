---
search:
  exclude: true
---

# Guion de clase UD7

## 1. Objetivos de aprendizaje

Al finalizar la UD7, el alumnado debe ser capaz de:

- Explicar qué son los grupos de seguridad y para qué se usan en un dominio.
- Diferenciar correctamente entre grupo, OU y GPO.
- Diseñar una estructura mínima de OU y grupos para una empresa.
- Crear y administrar grupos (Windows GUI y Samba CLI).
- Aplicar una estrategia de anidamiento para simplificar permisos.
- Crear, vincular y verificar directivas de grupo sobre objetos del dominio.

## 2. Teoría detallada

## 2.1 Equipos en dominio

Una cuenta de equipo representa a un cliente o servidor unido al dominio. Igual que una cuenta de usuario, tiene identidad propia dentro de Active Directory.

Para qué sirve:

- autenticar que el equipo pertenece al dominio
- aplicar políticas de equipo (GPO de Configuración del equipo)
- controlar qué recursos del dominio puede usar ese equipo

Idea clave de clase:

- usuario y equipo son objetos distintos
- un usuario puede cambiar de equipo, pero las políticas de equipo siguen dependiendo del objeto equipo y su OU

## 2.2 Grupos: concepto central de la unidad

Un grupo de AD es un contenedor lógico de usuarios, equipos u otros grupos para administrar permisos de forma conjunta.

Regla principal:

- los permisos se asignan a grupos, no a usuarios individuales

Ventajas:

- menos errores administrativos
- altas y bajas de personal más rápidas
- auditoría de permisos más clara
- escalabilidad cuando crece el dominio

### SID del grupo

Cada grupo tiene un SID (Security Identifier) único. El sistema usa ese SID internamente para validar permisos.

Consecuencias prácticas:

- renombrar un grupo no rompe permisos
- borrar y recrear un grupo con el mismo nombre no mantiene permisos anteriores (porque cambia el SID)

### Tipo de grupo

- `Security`: para control de acceso (ACL/DACL). Es el tipo habitual en esta unidad.
- `Distribution`: para listas de correo. No se usa para permisos de recursos.

### Ámbito de grupo

- `Domain Local (DL)`: pensado para asignar permisos a recursos del dominio donde existe el grupo.
- `Global (GG)`: pensado para agrupar cuentas por rol/departamento dentro del dominio.
- `Universal (UG)`: visible en todo el bosque. Útil en escenarios multi-dominio; en redes pequeñas se evita salvo necesidad real.

Resumen operativo:

- `GG` responde a “quiénes son”
- `DL` responde a “a qué recurso acceden”

### Ejemplo detallado: `DL_ERP_RW`

`DL_ERP_RW` es un nombre convencional:

- `DL`: ámbito Domain Local
- `ERP`: recurso objetivo (aplicación ERP)
- `RW`: permiso de lectura y escritura

Uso correcto:

1. Usuarios de Comercial -> grupo `GG_Comercial`.
2. Grupo `GG_Comercial` se añade a `DL_ERP_RW`.
3. El recurso ERP da permiso solo a `DL_ERP_RW`.

Beneficio:

- no editas ACL del ERP cada vez que entra/sale un empleado
- solo gestionas miembros del grupo global

### Anidamiento recomendado (AGDLP)

Modelo para dominio único:

1. `A` (Accounts): cuentas de usuario.
2. `G` (Global): grupos de rol o departamento.
3. `DL` (Domain Local): grupos de permiso sobre recurso.
4. `P` (Permissions): permisos efectivos en recurso.

Ejemplo rápido:

- `ana`, `luis`, `maria` -> `GG_Contabilidad`
- `GG_Contabilidad` -> `DL_Nominas_RW`
- carpeta `\\SRV\Nominas` con permiso `Modify` para `DL_Nominas_RW`

### Cómo explicarlo en clase

Explicación breve lista para decir en voz alta:

> Primero agrupo a las personas que hacen la misma función. Ese es el `GG`. Después creo otro grupo que representa el permiso sobre un recurso. Ese es el `DL`. Luego meto el `GG` dentro del `DL`. Eso es anidar grupos.

Idea para repetir:

- `GG` = quiénes son
- `DL` = a qué recurso acceden

Ejemplo de pizarra:

```text
maria -> GG_Comercial -> DL_ERP_RW -> ERP
```

Lectura didáctica:

- `maria` no recibe el permiso directamente
- el ERP solo conoce a `DL_ERP_RW`
- María entra porque su grupo de rol está anidado en el grupo de permiso

Analogía de aula:

- `GG_Comercial` es el grupo de personas del departamento
- `DL_ERP_RW` es el grupo que tiene la "llave" del ERP

Si cambia una persona de puesto, no se toca el recurso; se cambia su pertenencia al grupo.

## 2.3 OU (Unidades Organizativas)

Una OU es un contenedor jerárquico para organizar objetos del dominio (usuarios, equipos, grupos e incluso OU hijas).

Para qué se usa:

- organizar el directorio por departamentos o sedes
- delegar administración
- aplicar GPO a conjuntos completos de objetos

Diferencia esencial con grupos:

- grupo = permisos
- OU = organización + ámbito de aplicación de GPO

Regla importante:

- un objeto solo puede estar en una OU a la vez
- un usuario puede pertenecer a múltiples grupos

## 2.4 Diferencia grupo vs OU con ejemplo completo

Caso: usuaria `maria` (Comercial) también es responsable de área.

- `maria` pertenece a `GG_Comercial` y `GG_Responsables` (grupos).
- Su objeto usuario está en `OU=Comercial`.
- El acceso a recursos (ERP, carpetas, impresoras) depende de sus grupos.
- Las restricciones de entorno (panel de control, escritorio, scripts) dependen de la GPO aplicada a su OU.

Conclusión didáctica:

- para “qué puede abrir/modificar” piensa en grupos
- para “qué configuración se le aplica” piensa en OU + GPO

## 2.5 GPO: teoría imprescindible

Una GPO es un conjunto de configuraciones centralizadas para usuarios y equipos del dominio.

Se aplica en objetos contenedor (Sitio, Dominio, OU), no directamente a grupos.

Orden de procesamiento (resumen):

1. Local
2. Sitio
3. Dominio
4. OU (de padre a hijo)

Si hay conflicto, prevalece la política procesada más tarde (normalmente la más cercana al objeto).

### Herencia y bloqueo

- las OU hijas heredan GPO de niveles superiores
- puede bloquearse la herencia en una OU concreta
- bloquear herencia cambia totalmente el resultado efectivo de políticas

### Actualización de políticas

- automática cada cierto intervalo
- manual inmediata con:

```powershell
gpupdate /force
gpresult /r
```

## 2.6 Buenas prácticas UD7

- no asignar permisos directos a usuarios salvo excepción justificada
- definir convención de nombres (`GG_`, `DL_`, sufijos `_R`, `_RW`, `_RX`)
- evitar grupos `Universal` si no son necesarios
- separar GPO por objetivo (seguridad, escritorio, software)
- documentar cada GPO y su vínculo

## 2.7 Errores típicos de examen/práctica

- confundir OU con grupo
- aplicar GPO en OU equivocada
- olvidar `gpupdate /force` al validar
- crear grupos sin descripción funcional
- no justificar el ámbito del grupo elegido

## 3. Secuencia de clase recomendada (16 horas)

### Bloque A (4 h): Diseño de estructura

- teoría: grupo, OU, ámbito, anidamiento
- trabajo guiado: diseño de empresa (OU + grupos)
- producto del bloque: esquema validado por el profesor

### Bloque B (4 h): Implementación de grupos

- Windows GUI: creación y membresía
- Ubuntu/Samba CLI: réplica de la misma estructura

Comandos base:

```bash
samba-tool group add GG_Comercial --group-scope=Global --group-type=Security --description="Departamento Comercial"
samba-tool group add GG_Responsables --group-scope=Global --group-type=Security --description="Responsables de departamento"
samba-tool group addmembers GG_Comercial user_com1,user_com2,user_com3
samba-tool group addmembers GG_Responsables resp_comercial,resp_tic
samba-tool group listmembers GG_Comercial
```

### Bloque C (4 h): OU y ubicación de objetos

- creación de OU en Windows
- movimiento de usuarios/grupos/equipos según diseño
- validación de jerarquía final

Ejemplo OU objetivo:

```text
OU=Empresa
|- OU=Gerencia
|- OU=Administracion
|- OU=Comercial
|  |- OU=Ventas
|  |- OU=Compras
|- OU=TIC
```

### Bloque D (4 h): GPO y comprobación

- edición de `Default Domain Policy` para ajustes base
- creación de `Normas Empresa`
- vínculo a dominio/OU según planificación
- validación en cliente con `gpupdate /force` y pruebas reales

## 4. Guion directo para actividades obligatorias

## Actividad 1 (planificación)

1. Dibujar organigrama y pasarlo a OU.
2. Definir grupos por departamento (`GG_...`).
3. Definir grupos transversales (`GG_Responsables`, etc.).
4. Justificar ámbito de cada grupo.
5. Entregar esquema final antes de implementar.

## Actividad 2 (implementación)

1. Crear grupos en Windows (GUI) con descripción.
2. Añadir miembros según organigrama.
3. Repetir en Ubuntu con `samba-tool group`.
4. Crear y ordenar OU en Windows.
5. Ubicar objetos en su OU final.
6. Configurar GPO requeridas (Default + `Normas Empresa`).
7. Forzar actualización de políticas.
8. Validar efectos en clientes (`CW1001`, etc.).
9. Documentar con capturas y comandos.

## 5. Checklist de validación

- cada grupo tiene tipo `Security` y ámbito justificado
- usuarios en grupos correctos
- OU estructuradas según planificación
- GPO vinculadas al contenedor correcto
- políticas visibles/aplicadas en cliente
- evidencias incluidas (capturas + comandos)

## 6. Plantilla de entrega del alumnado

1. Planificación inicial (OU + grupos + anidamiento).
2. Implementación Windows (pasos GUI).
3. Implementación Ubuntu (comandos CLI).
4. Configuración GPO y validación.
5. Incidencias y resolución.

## 7. Glosario mínimo UD7

- `OU`: contenedor lógico del directorio para organizar objetos y aplicar GPO.
- `Grupo de seguridad`: objeto para agrupar identidades y asignar permisos.
- `Ámbito`: alcance del grupo (`DL`, `GG`, `UG`).
- `SID`: identificador único de seguridad de un objeto.
- `GPO`: conjunto de políticas aplicadas a usuarios/equipos del dominio.
- `Herencia`: propagación de políticas desde contenedores superiores a inferiores.
