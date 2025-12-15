# Guía Rápida - Actividad 3 bis

## 🚀 Inicio Rápido

```bash
# 1. Ir al directorio del lab
cd /home/julio/Documentos/ISO/ISONew/UD1/labs/actividad3bis

# 2. Levantar las máquinas
vagrant up

# 3. Esperar a que el servidor Windows se configure (5-10 min)

# 4. Acceder al cliente Ubuntu
vagrant ssh cliente_ubuntu

# 5. Unirse al dominio
sudo realm join MIDOMINIO.LOCAL -U Administrador
# Password: vagrant

# 6. Validar integración
./scripts/validar_integracion.sh
```

## 📋 Comandos Esenciales

### Gestión de VMs

```bash
vagrant up                    # Iniciar todas las VMs
vagrant up servidor_windows   # Iniciar solo el servidor
vagrant up cliente_ubuntu     # Iniciar solo el cliente
vagrant halt                  # Detener todas las VMs
vagrant reload                # Reiniciar las VMs
vagrant destroy -f            # Destruir las VMs
vagrant status                # Ver estado
```

### En el Cliente Ubuntu

```bash
# Conectarse
vagrant ssh cliente_ubuntu

# Descubrir dominio
realm discover MIDOMINIO.LOCAL

# Unirse al dominio
sudo realm join MIDOMINIO.LOCAL -U Administrador

# Ver estado
realm list

# Validar usuario
id usuario.prueba
getent passwd usuario.prueba

# Obtener ticket Kerberos
kinit usuario.prueba@MIDOMINIO.LOCAL
klist

# Permitir acceso a usuarios
sudo realm permit --all
sudo realm permit --groups "Domain Users"

# Configurar sudo para Domain Admins
echo "%domain\\ admins ALL=(ALL) ALL" | sudo tee /etc/sudoers.d/domain-admins
```

### En el Servidor Windows (PowerShell)

```powershell
# Verificar AD
Get-ADDomain
Get-ADUser -Filter *

# Crear usuario
$Password = ConvertTo-SecureString "Usuario123!" -AsPlainText -Force
New-ADUser -Name "Test User" -SamAccountName "test.user" -UserPrincipalName "test.user@midominio.local" -AccountPassword $Password -Enabled $true

# Ver usuarios
Get-ADUser -Filter * | Select-Object Name, SamAccountName

# Ver grupos
Get-ADGroup -Filter * | Select-Object Name
```

## 🔍 Troubleshooting Rápido

### Problema: No encuentra el dominio

```bash
# Verificar DNS
nslookup midominio.local
ping 192.168.56.10

# Reiniciar red
sudo netplan apply
```

### Problema: Error al unirse

```bash
# Limpiar Kerberos
sudo kdestroy
sudo rm -rf /tmp/krb5cc_*

# Reiniciar SSSD
sudo systemctl restart sssd

# Intentar de nuevo
sudo realm join MIDOMINIO.LOCAL -U Administrador -v
```

### Problema: Usuario no funciona

```bash
# Limpiar caché
sudo sss_cache -E

# Reiniciar SSSD
sudo systemctl restart sssd

# Verificar logs
sudo journalctl -u sssd -f
```

## 📊 Información del Lab

| Componente | Valor |
|------------|-------|
| **Dominio** | midominio.local |
| **Servidor IP** | 192.168.56.10 |
| **Cliente IP** | 192.168.56.20 |
| **Admin User** | Administrador |
| **Admin Pass** | vagrant |
| **Test User** | usuario.prueba@midominio.local |
| **Test Pass** | Usuario123! |

## ✅ Checklist de Validación

- [ ] `vagrant status` muestra ambas VMs running
- [ ] `ping 192.168.56.10` funciona desde el cliente
- [ ] `realm discover MIDOMINIO.LOCAL` muestra el dominio
- [ ] `realm list` muestra "configured: kerberos-member"
- [ ] `id usuario.prueba` muestra información del usuario
- [ ] `kinit usuario.prueba@MIDOMINIO.LOCAL` obtiene ticket
- [ ] `ssh usuario.prueba@localhost` permite login
- [ ] Directorio `/home/usuario.prueba` se crea automáticamente
- [ ] `sudo whoami` funciona (si está en Domain Admins)

## 📸 Capturas Necesarias para la Actividad

1. Configuración de red (`ip a` y `cat /etc/resolv.conf`)
2. `realm discover MIDOMINIO.LOCAL`
3. `sudo realm join MIDOMINIO.LOCAL -U Administrador`
4. `realm list`
5. `id usuario.prueba@midominio.local`
6. `klist`
7. Login con usuario de dominio
8. `ls -la /home/usuario.prueba`
9. `sudo whoami` como usuario de dominio
10. Configuración de sudoers

---

**Tip**: Usa `./scripts/validar_integracion.sh` para verificar todo automáticamente.
