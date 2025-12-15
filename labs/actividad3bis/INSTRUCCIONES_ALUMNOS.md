# Actividad 3 bis - Instrucciones para Alumnos

## 🎯 Objetivo

Unir un cliente Ubuntu al dominio de Active Directory y comprobar que se pueden ejecutar acciones con usuarios de dominio.

## 📋 Pasos a Realizar

### Paso 1: Preparar la Red del Cliente Ubuntu

**Objetivo**: Establecer el nombre de host y configurar el DNS apuntando al controlador de dominio.

```bash
# Verificar configuración de red
ip addr show
cat /etc/resolv.conf

# Verificar que el DNS apunta a 192.168.56.10
```

**📸 Captura 1**: Salida de `ip addr show` y `cat /etc/resolv.conf`

---

### Paso 2: Verificar Paquetes Instalados

Los siguientes paquetes ya están instalados en el laboratorio:
- `realmd`
- `sssd-ad`
- `sssd-tools`
- `adcli`
- `krb5-user`
- `samba-common-bin`
- `libpam-mkhomedir`
- `packagekit`

```bash
# Verificar instalación
dpkg -l | grep -E "realmd|sssd|krb5"
```

**📸 Captura 2**: Lista de paquetes instalados

---

### Paso 3: Descubrir el Dominio

```bash
realm discover MIDOMINIO.LOCAL
```

**Salida esperada**:
```
midominio.local
  type: kerberos
  realm-name: MIDOMINIO.LOCAL
  domain-name: midominio.local
  configured: no
  server-software: active-directory
  client-software: sssd
  required-package: sssd-tools
  required-package: sssd
  required-package: adcli
  required-package: samba-common-bin
```

**📸 Captura 3**: Salida completa de `realm discover`

---

### Paso 4: Unirse al Dominio

```bash
sudo realm join MIDOMINIO.LOCAL -U Administrador
```

- **Usuario**: `Administrador`
- **Contraseña**: `vagrant` (o la proporcionada por el profesor)

**Proceso**:
1. Introduce la contraseña cuando se solicite
2. Espera a que el proceso complete (1-2 minutos)
3. No debería mostrar errores

**📸 Captura 4**: Comando y salida de `realm join`

---

### Paso 5: Verificar la Unión al Dominio

```bash
realm list
```

**Salida esperada**:
```
midominio.local
  type: kerberos
  realm-name: MIDOMINIO.LOCAL
  domain-name: midominio.local
  configured: kerberos-member  ← IMPORTANTE: debe decir "kerberos-member"
  server-software: active-directory
  client-software: sssd
  ...
```

**📸 Captura 5**: Salida completa de `realm list`

---

### Paso 6: Habilitar Acceso a Usuarios del Dominio

```bash
# Permitir acceso a todos los usuarios del dominio
sudo realm permit --all

# O solo al grupo Domain Users
sudo realm permit --groups "Domain Users"
```

**📸 Captura 6**: Comandos ejecutados

---

### Paso 7: Conceder Privilegios de Administración

```bash
# Dar permisos sudo al grupo Domain Admins
echo "%domain\\ admins ALL=(ALL) ALL" | sudo tee /etc/sudoers.d/domain-admins

# Verificar permisos del archivo
sudo chmod 440 /etc/sudoers.d/domain-admins
sudo cat /etc/sudoers.d/domain-admins
```

**📸 Captura 7**: Contenido de `/etc/sudoers.d/domain-admins`

---

### Paso 8: Validar Identidad de Usuario

```bash
# Comprobar identidad del usuario de prueba
id usuario.prueba
id usuario.prueba@midominio.local

# También puedes usar getent
getent passwd usuario.prueba
```

**Salida esperada**:
```
uid=1234567890(usuario.prueba) gid=1234567890(domain users) groups=1234567890(domain users)
```

**📸 Captura 8**: Salida de `id usuario.prueba`

---

### Paso 9: Obtener Ticket Kerberos

```bash
# Obtener ticket Kerberos
kinit usuario.prueba@MIDOMINIO.LOCAL

# Verificar el ticket
klist
```

**Salida esperada de `klist`**:
```
Ticket cache: FILE:/tmp/krb5cc_1000
Default principal: usuario.prueba@MIDOMINIO.LOCAL

Valid starting     Expires            Service principal
12/15/25 10:00:00  12/15/25 20:00:00  krbtgt/MIDOMINIO.LOCAL@MIDOMINIO.LOCAL
```

**📸 Captura 9**: Salida de `klist`

---

### Paso 10: Iniciar Sesión con Usuario de Dominio

**Opción A: Por SSH**
```bash
# Desde el mismo cliente
ssh usuario.prueba@localhost

# Verificar que estás logueado
whoami
pwd
```

**Opción B: Por consola** (si GUI está habilitada)
- En la pantalla de login, usar: `usuario.prueba`
- Contraseña: `Usuario123!`

**📸 Captura 10**: Sesión iniciada como usuario de dominio

---

### Paso 11: Verificar Creación de Directorio Home

```bash
# Listar el directorio home del usuario
ls -la /home/usuario.prueba

# Verificar permisos
stat /home/usuario.prueba
```

**Salida esperada**:
```
total 20
drwxr-xr-x 2 usuario.prueba domain users 4096 Dec 15 10:00 .
drwxr-xr-x 3 root           root         4096 Dec 15 10:00 ..
-rw-r--r-- 1 usuario.prueba domain users  220 Dec 15 10:00 .bash_logout
...
```

**📸 Captura 11**: Salida de `ls -la /home/usuario.prueba`

---

### Paso 12: Ejecutar Comando con Sudo

```bash
# Iniciar sesión como usuario de dominio
ssh usuario.prueba@localhost

# Ejecutar comando con sudo (solo si está en Domain Admins)
sudo whoami
```

**Salida esperada**: `root`

**📸 Captura 12**: Ejecución de `sudo whoami`

---

## ✅ Script de Validación Automática

Para verificar que todo está correcto, ejecuta:

```bash
./scripts/validar_integracion.sh
```

Este script verifica automáticamente los 10 puntos críticos de la integración.

**📸 Captura 13**: Salida completa del script de validación

---

## 📊 Checklist de Entrega

Asegúrate de incluir en tu documentación:

- [ ] Captura 1: Configuración de red y DNS
- [ ] Captura 2: Paquetes instalados
- [ ] Captura 3: `realm discover`
- [ ] Captura 4: `realm join`
- [ ] Captura 5: `realm list` (debe mostrar "kerberos-member")
- [ ] Captura 6: Permisos de acceso configurados
- [ ] Captura 7: Configuración de sudoers
- [ ] Captura 8: `id usuario.prueba`
- [ ] Captura 9: `klist` mostrando ticket Kerberos
- [ ] Captura 10: Sesión iniciada como usuario de dominio
- [ ] Captura 11: Directorio home creado
- [ ] Captura 12: Ejecución de `sudo whoami`
- [ ] Captura 13: Script de validación
- [ ] Explicación de cada paso (breve)
- [ ] Problemas encontrados y cómo se resolvieron

---

## 🔧 Troubleshooting

### Problema: No encuentra el dominio

```bash
# Verificar DNS
nslookup midominio.local
ping 192.168.56.10

# Si falla, verificar /etc/resolv.conf
cat /etc/resolv.conf
```

### Problema: Error al unirse al dominio

```bash
# Limpiar caché de Kerberos
sudo kdestroy
sudo rm -rf /tmp/krb5cc_*

# Reiniciar SSSD
sudo systemctl restart sssd

# Intentar de nuevo
sudo realm join MIDOMINIO.LOCAL -U Administrador -v
```

### Problema: Usuario no se puede autenticar

```bash
# Limpiar caché de SSSD
sudo sss_cache -E

# Reiniciar SSSD
sudo systemctl restart sssd

# Verificar logs
sudo journalctl -u sssd -f
```

---

## 📚 Información del Laboratorio

| Componente | Valor |
|------------|-------|
| **Dominio** | midominio.local |
| **NetBIOS** | MIDOMINIO |
| **Servidor AD IP** | 192.168.56.10 |
| **Cliente IP** | 192.168.56.20 |
| **Usuario Administrador** | Administrador |
| **Password Administrador** | vagrant |
| **Usuario de Prueba** | usuario.prueba@midominio.local |
| **Password Usuario Prueba** | Usuario123! |

---

## 📝 Formato de Entrega

Crea un documento (PDF o Word) con:

1. **Portada**: Título, nombre, fecha
2. **Índice**
3. **Introducción**: Breve explicación del objetivo
4. **Desarrollo**: Los 12 pasos con sus capturas
5. **Conclusiones**: Qué aprendiste, dificultades encontradas
6. **Anexos**: Script de validación, configuraciones adicionales

**Fecha de entrega**: [A definir por el profesor]

---

**¡Buena suerte!** 🚀
