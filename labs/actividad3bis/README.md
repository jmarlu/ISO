# Laboratorio Actividad 3 bis - Cliente Ubuntu en Active Directory

## 📋 Descripción

Este laboratorio automatiza la creación de un entorno de prueba para la **Actividad 3 bis**, que consiste en unir un cliente Ubuntu a un dominio de Active Directory gestionado por Windows Server.

## 🏗️ Arquitectura del Laboratorio

```
┌─────────────────────────────────────────────────────────┐
│                  Red Privada: 192.168.56.0/24           │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────────────┐      ┌──────────────────────┐│
│  │  Servidor Windows    │      │   Cliente Ubuntu     ││
│  │  (AD Controller)     │      │                      ││
│  ├──────────────────────┤      ├──────────────────────┤│
│  │ IP: 192.168.56.10    │◄────►│ IP: 192.168.56.20    ││
│  │ Hostname: Servidor   │      │ Hostname: Cliente    ││
│  │          Windows     │      │          Ubuntu      ││
│  │                      │      │                      ││
│  │ Dominio:             │      │ DNS: 192.168.56.10   ││
│  │   midominio.local    │      │                      ││
│  │                      │      │ Unido al dominio:    ││
│  │ Roles:               │      │   midominio.local    ││
│  │  - AD DS             │      │                      ││
│  │  - DNS               │      │ Paquetes:            ││
│  │  - DHCP (opcional)   │      │  - realmd            ││
│  │                      │      │  - sssd              ││
│  │ RAM: 4GB             │      │  - krb5              ││
│  │ CPU: 2 cores         │      │                      ││
│  │                      │      │ RAM: 2GB             ││
│  │                      │      │ CPU: 2 cores         ││
│  └──────────────────────┘      └──────────────────────┘│
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## 📦 Requisitos Previos

### Software Necesario

1. **VirtualBox** (versión 6.1 o superior)
   ```bash
   sudo apt install virtualbox virtualbox-ext-pack
   ```

2. **Vagrant** (versión 2.2 o superior)
   ```bash
   wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   sudo apt update && sudo apt install vagrant
   ```

3. **Espacio en disco**: Mínimo 30GB libres en `/media/julio/cd470cc1-30fe-4ca0-ba50-33241e8616ba/MaquinasVirtuales/`

### Verificar Requisitos

```bash
# Verificar VirtualBox
vboxmanage --version

# Verificar Vagrant
vagrant --version

# Verificar espacio en disco
df -h /media/julio/cd470cc1-30fe-4ca0-ba50-33241e8616ba/MaquinasVirtuales/
```

## 🚀 Instalación y Configuración

### Paso 1: Preparar el Entorno

```bash
# Navegar al directorio del laboratorio
cd /home/julio/Documentos/ISO/ISONew/UD1/labs/actividad3bis

# Verificar que existe la ruta de almacenamiento
ls -la /media/julio/cd470cc1-30fe-4ca0-ba50-33241e8616ba/MaquinasVirtuales/
```

### Paso 2: Descargar las Boxes de Vagrant

```bash
# Descargar Windows Server 2022
vagrant box add gusztavvargadr/windows-server-2022-standard

# Descargar Ubuntu 22.04 LTS
vagrant box add ubuntu/jammy64
```

### Paso 3: Levantar el Laboratorio

```bash
# Iniciar ambas máquinas (tarda 10-15 minutos)
vagrant up

# O iniciarlas por separado:
vagrant up servidor_windows    # Primero el servidor
vagrant up cliente_ubuntu       # Después el cliente
```

### Paso 4: Verificar el Estado

```bash
# Ver el estado de las máquinas
vagrant status

# Debería mostrar:
# servidor_windows    running (virtualbox)
# cliente_ubuntu      running (virtualbox)
```

## 🔧 Configuración Manual Post-Instalación

### En el Servidor Windows

1. **Acceder al servidor** (se abrirá la GUI automáticamente)
   - Usuario: `vagrant` o `Administrador`
   - Password: `vagrant`

2. **Esperar a que complete la instalación de AD** (el servidor se reiniciará automáticamente)

3. **Verificar que AD está funcionando**:
   ```powershell
   # Abrir PowerShell como Administrador
   Get-ADDomain
   Get-ADUser -Filter *
   ```

4. **Crear usuarios adicionales** (opcional):
   ```powershell
   $Password = ConvertTo-SecureString "Usuario123!" -AsPlainText -Force
   New-ADUser -Name "Alumno Test" -SamAccountName "alumno.test" -UserPrincipalName "alumno.test@midominio.local" -AccountPassword $Password -Enabled $true
   ```

### En el Cliente Ubuntu

1. **Acceder al cliente**:
   ```bash
   vagrant ssh cliente_ubuntu
   ```

2. **Verificar conectividad con el servidor AD**:
   ```bash
   # Ping al servidor
   ping -c 4 192.168.56.10
   
   # Verificar resolución DNS
   nslookup servidorwindows.midominio.local
   nslookup midominio.local
   ```

3. **Descubrir el dominio**:
   ```bash
   realm discover MIDOMINIO.LOCAL
   ```
   
   Deberías ver información del dominio como:
   ```
   midominio.local
     type: kerberos
     realm-name: MIDOMINIO.LOCAL
     domain-name: midominio.local
     configured: no
     server-software: active-directory
     client-software: sssd
   ```

4. **Unirse al dominio**:
   ```bash
   sudo realm join MIDOMINIO.LOCAL -U Administrador
   ```
   
   - Te pedirá la password del Administrador: `vagrant` (o la que hayas configurado)
   - Espera a que complete (puede tardar 1-2 minutos)

5. **Verificar que se unió correctamente**:
   ```bash
   realm list
   ```

6. **Permitir acceso a usuarios del dominio**:
   ```bash
   # Permitir a todos los usuarios del dominio
   sudo realm permit --all
   
   # O solo al grupo Domain Users
   sudo realm permit --groups "Domain Users"
   ```

7. **Dar privilegios sudo a Domain Admins**:
   ```bash
   echo "%domain\\ admins ALL=(ALL) ALL" | sudo tee /etc/sudoers.d/domain-admins
   sudo chmod 440 /etc/sudoers.d/domain-admins
   ```

## ✅ Validación y Pruebas

### Prueba 1: Verificar Identidad de Usuario

```bash
# Desde el cliente Ubuntu
id usuario.prueba
id usuario.prueba@midominio.local

# Deberías ver información como:
# uid=1234567890(usuario.prueba) gid=1234567890(domain users) groups=...
```

### Prueba 2: Obtener Ticket Kerberos

```bash
# Obtener ticket
kinit usuario.prueba@MIDOMINIO.LOCAL

# Verificar ticket
klist

# Deberías ver:
# Ticket cache: FILE:/tmp/krb5cc_...
# Default principal: usuario.prueba@MIDOMINIO.LOCAL
```

### Prueba 3: Iniciar Sesión con Usuario de Dominio

```bash
# Opción 1: Desde consola local (si GUI está habilitada)
# En la pantalla de login, usar: usuario.prueba

# Opción 2: Por SSH
ssh usuario.prueba@192.168.56.20
# Password: Usuario123!

# Verificar que se creó el directorio home
ls -la /home/usuario.prueba
```

### Prueba 4: Verificar Permisos Sudo

```bash
# Iniciar sesión como usuario de dominio
ssh usuario.prueba@192.168.56.20

# Probar sudo (si el usuario está en Domain Admins)
sudo whoami
# Debería mostrar: root
```

### Prueba 5: Listar Usuarios del Dominio

```bash
# Desde el cliente Ubuntu
getent passwd | grep midominio

# O específicamente
getent passwd usuario.prueba
```

## 📊 Información de Credenciales

### Servidor Windows

| Componente | Valor |
|------------|-------|
| **Dominio** | midominio.local |
| **NetBIOS** | MIDOMINIO |
| **IP** | 192.168.56.10 |
| **Usuario Admin** | Administrador |
| **Password Admin** | vagrant |
| **Usuario Prueba** | usuario.prueba@midominio.local |
| **Password Prueba** | Usuario123! |

### Cliente Ubuntu

| Componente | Valor |
|------------|-------|
| **Hostname** | ClienteUbuntu |
| **IP** | 192.168.56.20 |
| **DNS** | 192.168.56.10 |
| **Usuario Local** | vagrant |
| **Password Local** | vagrant |

## 🛠️ Comandos Útiles de Vagrant

```bash
# Ver estado de las máquinas
vagrant status

# Iniciar una máquina específica
vagrant up servidor_windows
vagrant up cliente_ubuntu

# Detener las máquinas
vagrant halt

# Reiniciar las máquinas
vagrant reload

# Acceder por SSH (solo Ubuntu)
vagrant ssh cliente_ubuntu

# Reprovisionar (ejecutar scripts de nuevo)
vagrant provision

# Destruir las máquinas (CUIDADO: borra todo)
vagrant destroy

# Destruir y recrear
vagrant destroy -f && vagrant up
```

## 🔍 Troubleshooting

### Problema: No se puede descubrir el dominio

**Síntomas**: `realm discover` no encuentra el dominio

**Solución**:
```bash
# Verificar DNS
nslookup midominio.local
nslookup servidorwindows.midominio.local

# Verificar conectividad
ping 192.168.56.10

# Verificar que el servidor AD está funcionando
# (desde el servidor Windows)
Get-ADDomain
```

### Problema: Error al unirse al dominio

**Síntomas**: `realm join` falla con error de autenticación

**Soluciones**:
```bash
# 1. Verificar sincronización de tiempo
timedatectl status

# 2. Limpiar caché de Kerberos
sudo kdestroy
sudo rm -rf /tmp/krb5cc_*

# 3. Verificar configuración de Kerberos
cat /etc/krb5.conf

# 4. Probar autenticación manual
kinit Administrador@MIDOMINIO.LOCAL
```

### Problema: Usuario no puede iniciar sesión

**Síntomas**: `id usuario@midominio.local` no funciona

**Soluciones**:
```bash
# 1. Reiniciar SSSD
sudo systemctl restart sssd

# 2. Limpiar caché de SSSD
sudo sss_cache -E

# 3. Verificar logs
sudo journalctl -u sssd -f

# 4. Verificar permisos
sudo realm permit --all
```

### Problema: No se crea el directorio home

**Solución**:
```bash
# Verificar que pam_mkhomedir está habilitado
grep mkhomedir /etc/pam.d/common-session

# Habilitar manualmente
sudo pam-auth-update --enable mkhomedir
```

## 📚 Documentación de la Actividad

Para completar la **Actividad 3 bis**, documenta los siguientes pasos con capturas de pantalla:

1. ✅ Configuración de red del cliente Ubuntu (DNS apuntando al AD)
2. ✅ Salida del comando `realm discover MIDOMINIO.LOCAL`
3. ✅ Proceso de unión al dominio con `realm join`
4. ✅ Salida de `realm list` mostrando el dominio configurado
5. ✅ Comando `id usuario.prueba@midominio.local` mostrando información del usuario
6. ✅ Salida de `klist` mostrando el ticket Kerberos
7. ✅ Inicio de sesión con usuario de dominio (consola o SSH)
8. ✅ Verificación de creación de directorio home (`ls -la /home/usuario.prueba`)
9. ✅ Ejecución de comando con `sudo` como usuario de dominio
10. ✅ Configuración de sudoers para Domain Admins

## 🧹 Limpieza

Para eliminar completamente el laboratorio:

```bash
# Detener y destruir las máquinas
vagrant destroy -f

# Eliminar las boxes (opcional)
vagrant box remove gusztavvargadr/windows-server-2022-standard
vagrant box remove ubuntu/jammy64

# Las VMs se eliminan automáticamente de:
# /media/julio/cd470cc1-30fe-4ca0-ba50-33241e8616ba/MaquinasVirtuales/
```

## 📖 Referencias

- [Documentación oficial de Vagrant](https://www.vagrantup.com/docs)
- [Documentación de realmd](https://www.freedesktop.org/software/realmd/docs/)
- [Documentación de SSSD](https://sssd.io/docs/)
- [Active Directory en Windows Server](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/)

## 📝 Notas Adicionales

- Las máquinas virtuales se almacenan en: `/media/julio/cd470cc1-30fe-4ca0-ba50-33241e8616ba/MaquinasVirtuales/`
- El servidor Windows requiere aproximadamente 20GB de espacio
- El cliente Ubuntu requiere aproximadamente 8GB de espacio
- El primer `vagrant up` descargará las boxes (puede tardar según tu conexión)
- Se recomienda tener al menos 8GB de RAM en el host para ejecutar ambas VMs simultáneamente

---

**Autor**: Laboratorio creado para la asignatura ISO  
**Fecha**: Diciembre 2025  
**Versión**: 1.0
