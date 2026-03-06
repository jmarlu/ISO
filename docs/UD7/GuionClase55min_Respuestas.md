---
search:
  exclude: true
---

# Respuestas y justificaciones - Guion UD7 (55 min)

## 1. Pregunta rapida de control

### Pregunta
Si cambia una persona de puesto, donde tocamos primero: usuario o grupo?

### Respuesta modelo
Primero el **grupo** (membresia del usuario), no la ACL del recurso.

### Justificacion breve
La ACL debe apuntar a grupos de permiso estables (`DL_*`). Si cambian personas, solo se actualiza su pertenencia a `GG_*` y el acceso se ajusta sin rehacer permisos recurso por recurso.

## 2. Ticket de salida

### Pregunta 1
Diferencia entre `Grupo` y `OU`.

### Respuesta modelo
- `Grupo`: se usa para **asignar permisos** y derechos.
- `OU`: se usa para **organizar objetos** y **aplicar GPO**.

### Justificacion breve
Un usuario puede estar en varios grupos (varios permisos), pero solo en una OU a la vez (ubicacion administrativa y alcance de politicas).

### Pregunta 2
Por que se recomienda `GG -> DL -> permisos`.

### Respuesta modelo
Porque separa identidad y recurso:
- `GG` agrupa personas por rol/departamento.
- `DL` representa el permiso sobre un recurso.
- el recurso solo concede permiso a `DL`.

### Justificacion breve
Escala mejor, reduce errores y facilita altas/bajas/cambios: casi todo se resuelve cambiando membresias, no tocando ACL.

### Pregunta 3
Que comando usan para forzar politicas.

### Respuesta modelo
`gpupdate /force`

### Justificacion breve
Aplica de inmediato la actualizacion de directivas en el cliente sin esperar al ciclo periodico. Para comprobar resultado: `gpresult /r`.

## 3. Justificaciones rapidas que suelen pedir

### Por que `Global` para `GG_Comercial`
Porque agrupa cuentas del propio dominio por funcion/rol.

### Por que `Domain Local` para `DL_ERP_RW`
Porque ese grupo es el que recibe permisos directos sobre el recurso del dominio.

### Por que evitar permisos directos a usuarios
Porque rompe la trazabilidad y hace costosa la administracion cuando hay cambios de personal.

### Por que no cargar `Default Domain Policy` con todo
Porque se recomienda reservarla para configuraciones base de seguridad y crear GPO especificas por objetivo.

## 4. Frases cortas para usar en clase

- "Grupo responde a: que puede hacer."
- "OU responde a: donde esta y que politicas hereda."
- "Si hay duda, permisos a grupos, nunca a usuarios sueltos."
