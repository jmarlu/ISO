---
search:
  exclude: true
---

# Guion de clase (resumen practico) - UD7

## 1. Objetivo de la sesion

Al terminar la clase, el alumnado debe saber diseñar y aplicar una estructura basica de:

- cuentas/equipos del dominio
- grupos de seguridad
- unidades organizativas (OU)
- directivas de grupo (GPO)

Con validacion real en cliente (`gpupdate /force` + comprobacion).

## 2. Ideas clave para explicar en 5 minutos

- `Grupo` = permisos sobre recursos (quien accede).
- `OU` = organizacion + alcance de GPO (a quien se aplica configuracion).
- `GPO` = reglas centralizadas de equipo/usuario.
- Regla de oro: permisos a grupos, no a usuarios sueltos.
- Modelo recomendado en dominio unico: `A -> GG -> DL -> Permisos (AGDLP)`.

## 3. Guion practico de clase (4 horas)

## Bloque A (0:00-0:45) - Diseno rapido

1. Presentar un caso de empresa (Gerencia, Administracion, Comercial, TIC).
2. Dibujar en pizarra:
   - OU por departamentos.
   - grupos globales por rol (`GG_Comercial`, `GG_TIC`).
   - grupos de permiso por recurso (`DL_ERP_RW`, `DL_DatosCom_R`).
3. Pregunta de control:
   - Si Maria cambia de departamento, que tocamos primero: ACL o grupo?

## Bloque B (0:45-1:45) - Implementacion guiada

En `ServidorWindows`:

1. Crear OU segun diseno.
2. Crear grupos de seguridad con descripcion funcional.
3. Meter usuarios en grupos.
4. Crear GPO `Entorno Corporativo` y vincularla a OU de empleados.

En `ServidorUbuntu` (Samba AD):

```bash
samba-tool group add GG_Comercial --group-scope=Global --group-type=Security --description="Departamento Comercial"
samba-tool group add DL_ERP_RW --group-scope=Domain --group-type=Security --description="Acceso ERP lectura/escritura"
samba-tool group addmembers GG_Comercial user_com1,user_com2
samba-tool group addmembers DL_ERP_RW GG_Comercial
samba-tool group listmembers DL_ERP_RW
```

## Bloque C (1:45-2:45) - GPO y verificacion

1. Crear GPO `Normas Empresa` (no sobrecargar `Default Domain Policy`).
2. Vincular en el contenedor correcto (dominio u OU segun objetivo).
3. Forzar y comprobar en cliente:

```powershell
gpupdate /force
gpresult /r
```

4. Verificar 3 efectos visibles (por ejemplo):
   - restriccion de configuracion de escritorio
   - ocultacion de opciones no autorizadas
   - bloqueo de pantalla por inactividad

## Bloque D (2:45-4:00) - Actividad evaluable corta

Reto por parejas:

1. Crear 2 OU y 3 grupos (`GG_`, `DL_`).
2. Aplicar una GPO de entorno a una OU concreta.
3. Demostrar que un usuario recibe la politica y otro no (por OU distinta).
4. Entregar evidencia minima:
   - captura de OU y grupos
   - captura de vinculo GPO
   - salida de `gpresult /r`

## 4. Cierre de clase (5 minutos)

Resumen final para repetir al grupo:

1. Los permisos van a grupos.
2. Las GPO se vinculan a Sitio/Dominio/OU, no a grupos.
3. OU organiza objetos y controla alcance de politicas.
4. `gpupdate /force` acelera pruebas.
5. Sin plan de nombres y anidamiento, el dominio se vuelve inmantenible.

## 5. Checklist rapido del docente

- Se diferencian correctamente grupo vs OU.
- Se justifica el ambito de cada grupo (Global/Domain Local/Universal).
- La GPO esta vinculada donde corresponde.
- El cliente refleja cambios tras `gpupdate /force`.
- La documentacion incluye comandos y evidencias.
