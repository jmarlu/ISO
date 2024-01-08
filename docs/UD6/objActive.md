# Objetos predeterminados de Active Directory

Un dominio contiene objetos que se crean de forma predeterminada tras su instalación. Estos objetos proporcionan acceso al sistema a varios niveles e incluyen grupos que permiten a los administradores delegar tareas específicas de mantenimiento de la red a otros usuarios. Incluso si no se espera usar esos objetos en el futuro, hay que utilizarlos para crear otros objetos derivados con los permisos apropiados para la red. Por ejemplo, aún si no se desea tener ningún usuario único con el control completo concedido a la cuenta de administrador, hay que iniciar sesión como administrador para poder crear los nuevos objetos usuario con los derechos y permisos deseados. Es posible dejar partes de la estructura del directorio desatendidas si se modifica, borra o desactiva la cuenta de administrador sin haber creado primero otros objetos usuario o haberles concedido permisos equivalentes para las distintas partes del directorio.
Los contenedores con los que arranca un dominio en Microsoft Windows Server son:

- **builtin**, contenedor predeterminado para los grupos que proporcionan acceso a las funciones de administración del servidor.
- **computers**, contenedor predeterminado para las cuentas de equipos.
- **users**, contenedor predeterminado para cuentas de usuario.
- **domain cotrollers**, contenedor para los nuevos controladores de dominio.
- **foreign security principals**, contenedor para entidades de seguridad de dominios de confianza externos. Es recomendable que los administradores no deben modificar manualmente el contenido de este contenedor ya que estas políticas se generan de forma automática al crear relaciones de confianza entre dominios.
- **managed service accounts** , contenedor para objetos que permiten la administración de servicios ajenos a Active Directory.

!!! note annotate "Realación de confianza"

      Una **relación de confianza** es una relación establecida  entre dos dominios de forma que permite a los usuarios de uno ser reconocidos por los controladores de dominio del otro. Estas relaciones permiten administrar desde un solo punto de la red a todos los usuarios y recursos de los que dispone el directorio.

Todos estos contenedores están destinados a asegurar el funcionamiento de los servicios de directorio y su configuración dependerá de la relación entre ellos. En cuanto a los usuarios creados por defecto, todo sistema de directorio debe contener al menos estos tres:

- **administrador**, cuenta integrada para la administración del dominio.
- **invitado**, cuenta integrada para el acceso como invitado al dominio.
- **default** account, cuenta de usuario administrada por el sistema.

También en Ubuntu Server se generan usuarios por defecto. Para poder acceder a ellos es necesario usar la aplicación `samba-tool user` en la línea de comandos. Las opciones que facilita esta herramienta son similares a las que podemos encontrar en el menú Acción de la Utilidad Usuarios y Active Directory:

```bash title=""
samba-tool user –help
Usage: samba-tool user <subcommand>

User management.

Options:
-h, --help show this help message and exit

Available subcommands:
add - Create a new user.
create - Create a new user.
delete - Delete a user.
disable - Disable an user.
enable - Enable an user.
list - List all users.
password - Change password for a user account.
setexpiry - Set the expiration of a user account.
setpassword - Set or reset the password of a user account.

For more help on a specific subcommand, please type: samba-tool user <subcommand> (-h|--help)
```

Son tres los usuarios que Samba crea en su estructura de dominio y que se pueden consultar a través del siguiente comando:
samba-tool user list

- **Administrator**, cuenta de usuario del administrador del dominio. Atención que el nombre de este usuario está escrito en inglés, no en castellano.
- **krbtgt**, cuenta de usuario del servicio Kerberos.
- **Guest**, cuenta limitada para acceso temporal al directorio.

Utilizando `samba-tool user` se administran los usuarios de un directorio bajo Ubuntu Server

```bash title=""
  samba-tool user add UsuarioFeo Passw0rdFeo
```

El comando anterior creará un usuario con el nombre UsuarioFeo y contraseña **Passw0rdFeo** aplicando de forma automática todas las opciones obligatorias del usuario y dejando en blanco las opcionales. Algunas de estas opciones de usuario son:

- **--given-name**, nombre del usuario, no el de inicio de sesión, sino el que aparecerá en la descripción del usuario.
- **--surname**, apellido.
- **--mail-address**, dirección de correo electrónico.
- **--uid-number**, número identificativo del usuario en formato RFC2307. Si no se especifica el sistema otorgará uno por defecto.
- **--**gid-number, número identificativo del grupo primario al que pertenece. Por defecto, todos los usuarios pertenecen al grupo Users como mínimo.
- **--login-shell**, especifica el bash que el usuario debe utilizar.
- **--home-directory**, directorio de usuario en el sistema.

Si es necesario cambiar la contraseña del usuario

```bash
samba-tool user setpassword UsuarioFeo
```

El comando para eliminar el usuario creado anteriormente es

```bash
samba-tool user delete UsuarioFeo
```

Existen numerosas opciones y modificadores de esta utilidad. Todas ellas se pueden consultar a través del comando

```bash
samba-tool user add --help
```

Ambos sistemas ofrecen numerosas posibilidades para la gestión de usuarios a través de diferentes tipos de interfaces. En este manual utilizaremos la interfaz GUI con Microsoft Windows Server y la interfaz **CLI** con Ubuntu Server, como viene siendo habitual.
