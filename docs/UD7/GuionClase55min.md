---
search:
  exclude: true
---

# Guion de clase (sesion 55 minutos) - UD7

## 1. Objetivo de la sesion

Al final de la clase, el alumnado debe poder:

- diferenciar `Grupo`, `OU` y `GPO`
- crear una estructura minima (`OU` + `GG` + `DL`)
- comprobar aplicacion de una politica en cliente

## 2. Temporalizacion (55 min)

## Tramo 1 (0-5 min) - Inicio

1. Contexto: "Hoy organizamos un dominio para que sea administrable".
2. Resultado esperado: una OU, dos grupos y una GPO funcionando.
3. Criterio de exito: evidencia con `gpresult /r`.

## Tramo 2 (5-12 min) - Marco minimo

- `Grupo` = permisos (quien accede).
- `OU` = organizacion y alcance de GPO (a quien se configura).
- `GPO` = reglas centralizadas.
- Regla clave: permisos a grupos, no a usuarios directos.

Pregunta rapida de control:
"Si cambia una persona de puesto, donde tocamos primero: usuario o grupo?"

## Tramo 3 (12-27 min) - Demo guiada 1 (estructura)

En `ServidorWindows`:

1. Crear OU `Empleados`.
2. Crear `GG_Comercial` (Global, Security).
3. Crear `DL_ERP_RW` (Domain Local, Security).
4. Anidar `GG_Comercial` dentro de `DL_ERP_RW`.

Referencia CLI equivalente en Samba:

```bash
samba-tool group add GG_Comercial --group-scope=Global --group-type=Security --description="Departamento Comercial"
samba-tool group add DL_ERP_RW --group-scope=Domain --group-type=Security --description="Acceso ERP lectura/escritura"
samba-tool group addmembers DL_ERP_RW GG_Comercial
samba-tool group listmembers DL_ERP_RW
```

## Tramo 4 (27-40 min) - Demo guiada 2 (GPO)

1. Crear GPO `Entorno Corporativo`.
2. Vincularla a `OU=Empleados`.
3. Configurar 1 ajuste visible (por ejemplo, bloqueo de cambio de fondo).
4. En cliente:

```powershell
gpupdate /force
gpresult /r
```

Comprobacion: el usuario dentro de la OU recibe la politica.

## Tramo 5 (40-50 min) - Practica rapida por parejas

Reto:

1. Crear `OU=Practica`.
2. Crear `GG_Practica` y `DL_Practica_R`.
3. Vincular una GPO simple a la OU.
4. Verificar con `gpresult /r`.

Evidencia minima:

- captura de OU y grupos
- captura del vinculo GPO
- salida de `gpresult /r`

## Tramo 6 (50-55 min) - Cierre y ticket de salida

Cada pareja responde en 1 minuto:

1. Diferencia entre `Grupo` y `OU`.
2. Por que se recomienda `GG -> DL -> permisos`.
3. Que comando usan para forzar politicas.

## 3. Checklist docente express

- No hay permisos directos a usuarios.
- Ambito de grupo justificado (Global vs Domain Local).
- GPO vinculada al contenedor correcto.
- Validacion real en cliente completada.

## Anexo - Respuestas y justificaciones rapidas

## A. Pregunta de control

Pregunta:
Si cambia una persona de puesto, donde tocamos primero: usuario o grupo?

Respuesta modelo:
Primero el **grupo** (membresia del usuario), no la ACL del recurso.

Justificacion:
La ACL debe apuntar a grupos de permiso estables (`DL_*`). Si cambian personas, solo se ajusta la pertenencia a `GG_*`.

## B. Ticket de salida

Pregunta 1:
Diferencia entre `Grupo` y `OU`.

Respuesta modelo:
- `Grupo`: asigna permisos y derechos.
- `OU`: organiza objetos y define alcance de GPO.

Justificacion:
Un usuario puede estar en varios grupos, pero en una sola OU a la vez.

Pregunta 2:
Por que se recomienda `GG -> DL -> permisos`.

Respuesta modelo:
`GG` agrupa identidades por rol y `DL` representa el permiso del recurso; la ACL se da a `DL`.

Justificacion:
Reduce errores y simplifica altas, bajas y cambios sin tocar ACL en cada recurso.

Pregunta 3:
Que comando usan para forzar politicas.

Respuesta modelo:
`gpupdate /force`

Justificacion:
Actualiza de inmediato las directivas en cliente. Verificacion: `gpresult /r`.

## C. Justificaciones frecuentes en clase

- `Global` para `GG_Comercial`: agrupa cuentas del propio dominio por rol.
- `Domain Local` para `DL_ERP_RW`: recibe permisos directos sobre el recurso.
- Evitar permisos directos a usuarios: complica mantenimiento y auditoria.
- No sobrecargar `Default Domain Policy`: mejor crear GPO especificas por objetivo.
