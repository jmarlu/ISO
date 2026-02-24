---
search:
  exclude: true
---

# Guion de clase UD6

## 1. Objetivos de la sesión

Al finalizar la UD6, el alumnado debe ser capaz de:

- Crear y administrar usuarios de dominio en Windows Server (GUI) y en Ubuntu (CLI con `samba-tool`).
- Aplicar políticas de contraseña y bloqueo de cuenta.
- Configurar scripts de inicio de sesión.
- Configurar perfiles móviles y carpetas personales.
- Aplicar restricciones de caducidad y cambio de contraseña en usuarios locales y de dominio.

## 2. Resumen rápido de la UD6

1. Administración de usuarios en AD: cuentas, OU, grupos y propiedades de inicio de sesión.
2. Objetos predeterminados: `Builtin`, `Users`, `Computers`, `Domain Controllers`.
3. Política de contraseñas y bloqueo: GPO en Windows y `chage`/política de dominio en Linux-Samba.
4. Scripts de inicio: pestaña Perfil en AD, `--script-path` o `.bashrc` en Linux.
5. Directivas de seguridad locales: en dominio prevalece GPO.
6. Perfiles: local, móvil, obligatorio.
7. Carpetas personales y redirección: rutas UNC en Windows y montaje NFS en Linux.
8. Variables de entorno útiles: `%USERNAME%`, `%USERPROFILE%`, `$USER`, `$HOME`, `$PATH`.

## 3. Secuencia recomendada de clase (16 horas)

### Bloque A (4 h): Usuarios y objetos del dominio

- Explicación: diferencia entre usuario local, usuario de dominio y plantilla.
- Demostración Windows:
  - Herramienta: `Usuarios y equipos de Active Directory`.
  - Crear usuario responsable por departamento.
- Demostración Ubuntu:

```bash
samba-tool user add resp_ventas 'P@ssw0rd123' --given-name='Ana' --surname='Lopez' --mail-address='ana@empresa.local'
samba-tool user list
```

- Cierre: verificar inicio de sesión en cliente.

### Bloque B (4 h): Contraseñas y bloqueo

- Explicación: historial, vigencia, longitud mínima y complejidad.
- Demostración Windows (GPO):
  - Historial = 3
  - Vigencia máxima = 10 días
  - Vigencia mínima = 3 días
  - Longitud mínima = 5
  - Complejidad = deshabilitada (solo para práctica)
- Demostración Linux local (`chage`):

```bash
sudo chage -d 0 usuario_local
sudo chage -M 30 usuario_local
sudo chage -m 7 usuario_local
sudo chage -W 7 usuario_local
sudo chage -E $(date -d "+180 days" +%F) usuario_local
sudo chage -l usuario_local
```

- Demostración Samba dominio:

```bash
samba-tool user setexpiry resp_ventas --days=180
samba-tool user setpassword resp_ventas --must-change-at-next-login
samba-tool domain passwordsettings set \
  --min-pwd-age=7 \
  --max-pwd-age=30 \
  --history-length=3 \
  --min-pwd-length=5 \
  --complexity=off
samba-tool domain passwordsettings show
```

### Bloque C (4 h): Scripts de inicio y variables de entorno

- Explicación: para qué sirve automatizar tareas al iniciar sesión.
- Ejemplo Windows (`inicio.ps1`):
  - mensaje de bienvenida
  - carpeta en escritorio
  - log de inicio
  - mapeo de unidad
- Ejemplo Linux (`inicio.sh` de la UD6):

```bash
#!/bin/bash
echo "Bienvenido/a $USER. Fecha: $(date)" | wall 2>/dev/null
CARPETA="$HOME/mi_carpeta"
mkdir -p "$CARPETA"
echo "Inicio de sesión de $USER en $(hostname) a las $(date)" >> "$CARPETA/login.txt"
```

- Variables clave para reutilizar en scripts:

```bash
# Linux
$USER  $HOME  $PATH

# Windows
%USERNAME%  %USERPROFILE%  %USERDOMAIN%
```

### Bloque D (4 h): Perfiles móviles y carpetas personales

- Explicación: perfil local vs móvil vs obligatorio.
- Demostración Windows:
  - Compartir carpeta `Perfiles`.
  - En usuario, ruta de perfil: `\\Servidor\Perfiles\%UserName%`.
  - Carpeta personal con unidad `X:`: `\\Servidor\Datos\%USERNAME%`.
- Demostración Linux (NFS):

```bash
sudo apt-get install -y portmap nfs-common
sudo /etc/init.d/portmap restart
sudo mount -t nfs ip-servidor:/home/empresa.local/usuario/datos /home/usuario/Datos
```

- Persistencia en `/etc/fstab` (ejemplo):

```fstab
ip-servidor:/home/empresa.local/%USER%/Datos /home/usuario/Escritorio/Datos nfs defaults 0 0
```

## 4. Guion directo para hacer las actividades obligatorias

## Actividad 1 (plantilla de ejecución)

1. Crear responsables por departamento en Windows (1 por departamento).
2. Probar login en cliente `CW1001` o `CW1002`.
3. Crear esos responsables en Ubuntu con `samba-tool user add`.
4. Verificar con `samba-tool user list` y prueba de autenticación.
5. Evidencias mínimas:
   - captura de creación de usuario
   - captura de login correcto
   - comando usado en Ubuntu + salida

Comando base reutilizable:

```bash
samba-tool user add resp_tic 'P@ssw0rd123' --given-name='Luis' --surname='Garcia' --mail-address='luis@empresa.local'
```

## Actividad 2 (plantilla de ejecución)

1. Crear plantillas de usuario por departamento.
2. Crear 3 empleados por departamento desde plantilla.
3. Forzar cambio de contraseña al primer inicio.
4. Restringir equipos de inicio (mitad en `CW1001`, mitad en `CW1002`; TIC sin restricción).
5. Restringir horario por departamento (mañana/tarde).
6. Configurar política de contraseña y bloqueo en GPO.
7. Asignar scripts de inicio:
   - Windows: `inicio.bat` en perfil de responsables
   - Ubuntu: `inicio.sh` o `--script-path`
8. Configurar caducidad y renovación de contraseñas:
   - Locales Linux: `chage`
   - Dominio Samba: `samba-tool user setexpiry` + `domain passwordsettings`
9. Configurar perfiles móviles para responsables (`Perfiles`).
10. Configurar carpetas personales:
   - Windows: unidad `X:` a `\\Servidor\Datos\%USERNAME%`
   - Linux: montaje NFS en carpeta `Datos`

## 5. Checklist de validación en clase

- El usuario inicia sesión donde corresponde (equipo/horario correcto).
- Se solicita cambio de contraseña en primer login.
- La política de dominio se refleja en pruebas reales de cambio de contraseña.
- El script de inicio genera evidencia (`login.txt`, carpeta creada, mensaje).
- El perfil móvil mantiene escritorio/configuración al cambiar de cliente.
- La carpeta personal aparece como `X:` (Windows) o montada en `Datos` (Linux).

## 6. Errores frecuentes y corrección rápida

- Usuario no puede iniciar: revisar OU, grupo, equipo permitido y horario.
- GPO no aplicada: ejecutar `gpupdate /force` en cliente y volver a validar.
- Script no corre: revisar ruta/nombre/extensión y permisos de lectura.
- Perfil móvil no carga: comprobar recurso compartido y permisos NTFS/compartición.
- NFS no monta: revisar paquetes, exportación en servidor y línea de `fstab`.

## 7. Entrega recomendada del alumnado

Documento breve por actividad con:

1. Objetivo.
2. Pasos ejecutados.
3. Comandos/rutas concretas.
4. Capturas de verificación.
5. Incidencias y solución aplicada.
