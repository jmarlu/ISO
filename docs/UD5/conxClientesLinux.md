# Conexión de clientes a un controlador de dominio en GNU/Linux

Un controlador de dominio configurado con Samba 4 posee los mismos protocolos que uno configurado a través de Microsoft Windows Server . Cuando el cliente se conecta a un servicio de directorio, no distingue si detrás de esos protocolos existe un sistema operativo de Microsoft o basado en GNU/Linux. Esta configuración es transparente al cliente por eso el método de conexión a diferentes servicios de directorio es el mismo. Los únicos cambios que será necesario realizar en el proceso de instalación, serán los datos del dominio y el nombre de host, el resto de necesidades, instalaciones y configuraciones serán idénticas.

## Unión de un cliente Ubuntu a Active Directory (realmd + SSSD)

En equipos Ubuntu recientes la forma más estable de integrarse con Active Directory es usando `realmd` y `sssd`, que delegan la autenticación en Kerberos/LDAP y crean cuentas de dominio al vuelo.

Pasos recomendados:

1. **Preparación de red**: fija el nombre de host (`/etc/hostname`) y apunta el DNS del cliente al controlador de dominio.
2. **Paquetes**:
   ```bash
   sudo apt update
   sudo apt install realmd sssd-ad sssd-tools adcli samba-common-bin oddjob-mkhomedir packagekit
   ```
   El servicio `oddjob-mkhomedir` permite crear el directorio personal la primera vez que entra un usuario del dominio.
3. **Descubrir el dominio**:
   ```bash
   realm discover midominio.local
   ```
4. **Unir el equipo** (usa la cuenta con permisos de unión en el dominio):
   ```bash
   sudo realm join midominio.local -U Administrador
   ```
   Verifica con `realm list` que el cliente quedó unido.
5. **Configurar creación de home automática**:
   ```bash
   sudo systemctl enable --now oddjobd
   sudo pam-auth-update --enable mkhomedir
   ```
6. **Permisos y sudo** (ejemplo: permitir iniciar sesión a un grupo y darle sudo):
   ```bash
   sudo realm permit --groups "Domain Users"
   echo "%domain\\ admins ALL=(ALL) ALL" | sudo tee /etc/sudoers.d/domain-admins
   ```
7. **Probar inicio de sesión** con un usuario del dominio:
   ```bash
   id usuario@midominio.local
   klist
   ssh usuario@midominio.local@clienteubuntu
   ```
   Debe crearse el home en `/home/DOMINIO/usuario` y recibir un ticket Kerberos válido.

Si se cambia el controlador de dominio o el sufijo, recuerda actualizar el DNS y volver a ejecutar `realm join` para reestablecer la confianza.
