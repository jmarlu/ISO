---
search:
  exclude: true
---
# Soluciones UD5 (DNS, DHCP, unión al dominio y administración remota)

> Documento guía para resolver las actividades de la UD5.
> 
> **Configuración aplicada según tus apuntes**:
> - `DOMINIO`: `miempresafea.local`
> - `ServidorWindows` (ejemplo usado en UD5): `192.168.100.100`
> - `ServidorUbuntu` (ejemplo usado en UD4/UD5): `10.0.3.3`
> - Si tu práctica usa otras IP, cambia solo esos valores.

---

## Actividad 1 (DNS)

### 1) ServidorWindows: crear registros A de equipos del dominio (gráfico)

1. Abre `Administrador del servidor -> Herramientas -> DNS`.
2. Ve a `Zonas de búsqueda directa -> miempresafea.local`.
3. Clic derecho `Host nuevo (A o AAAA)`.
4. Crea un host A por cada equipo (servidores y clientes):
   - `ServidorWindows -> 192.168.100.100`
   - `ServidorUbuntu -> 10.0.3.3`
   - `cw1001 -> IP correspondiente`
   - `cu1801 -> IP correspondiente`
5. Marca “Crear registro PTR asociado” cuando proceda.

### 2) ServidorUbuntu: crear zona inversa (CLI)

```bash
samba-tool dns zonelist miempresafea.local
samba-tool dns zonecreate miempresafea.local 3.0.10.in-addr.arpa
samba-tool dns zonelist miempresafea.local
```

> Si en tu Ubuntu tienes otra red distinta, cambia `3.0.10.in-addr.arpa` por la zona inversa real.

### 3) Crear alias CNAME y comprobar

En Windows DNS (gráfico), dentro de zona directa de `miempresafea.local` crea:
- `www` -> apunta al servidor.
- `ftp` -> apunta a un cliente.
- `correo` -> apunta a un host A inventado (IP no existente).

Comprobación desde cliente:

```bash
nslookup www.miempresafea.local
nslookup ftp.miempresafea.local
nslookup correo.miempresafea.local
ping www.miempresafea.local
ping ftp.miempresafea.local
ping correo.miempresafea.local
```

Resultado esperado:
- `www` y `ftp`: deben resolver por DNS; `ping` responde si el equipo destino está encendido y accesible.
- `correo`: puede resolver nombre->IP (si existe el registro), pero `ping` fallará porque el equipo/IP no existe.

---

## Actividad 2 (DHCP)

### 1) DHCP en ServidorWindows (gráfico)

1. `Administrador del servidor -> Agregar roles y características -> Servidor DHCP`.
2. Termina instalación **sin configurar durante el asistente**.
3. En consola DHCP:
   - Crea ámbito con todas las IP de la red.
   - Exclusión: IP fija del servidor.
   - Reserva 1: primeras 10 IP del rango.
   - Reserva 2: últimas 10 IP del rango.
   - Concesión: `15 horas`.
4. Autoriza el servidor DHCP y activa ámbito.

### 2) DHCP en ServidorUbuntu (CLI)

Instala servicio:

```bash
sudo apt update
sudo apt install isc-dhcp-server -y
```

Configura `/etc/dhcp/dhcpd.conf` (ejemplo adaptado):

```conf
option domain-name "miempresafea.local";
option domain-name-servers 172.16.0.1;
default-lease-time 54000;
max-lease-time 54000;
authoritative;

# Red de tipo B: 172.16.0.0/16
# Ambito 1: tercer byte = 0 (172.16.0.x)
# Ambito 2: resto de direcciones (172.16.1.x ... 172.16.255.x)
subnet 172.16.0.0 netmask 255.255.0.0 {
  option routers 172.16.0.1;
  option subnet-mask 255.255.0.0;
  option broadcast-address 172.16.255.255;

  # Ambito 1: tercer byte a 0
  pool {
    range 172.16.0.11 172.16.0.200;
  }

  # Ambito 2: resto de direcciones disponibles
  pool {
    range 172.16.1.11 172.16.255.200;
  }
}

# Reservas ejemplo (5 primeras y 5 últimas según red real)
host reserva01 { hardware ethernet 08:00:27:AA:AA:01; fixed-address 172.16.0.2; }
host reserva02 { hardware ethernet 08:00:27:AA:AA:02; fixed-address 172.16.0.3; }
host reserva03 { hardware ethernet 08:00:27:AA:AA:03; fixed-address 172.16.0.4; }
host reserva04 { hardware ethernet 08:00:27:AA:AA:04; fixed-address 172.16.0.5; }
host reserva05 { hardware ethernet 08:00:27:AA:AA:05; fixed-address 172.16.0.6; }

host reserva96 { hardware ethernet 08:00:27:BB:BB:96; fixed-address 172.16.255.250; }
host reserva97 { hardware ethernet 08:00:27:BB:BB:97; fixed-address 172.16.255.251; }
host reserva98 { hardware ethernet 08:00:27:BB:BB:98; fixed-address 172.16.255.252; }
host reserva99 { hardware ethernet 08:00:27:BB:BB:99; fixed-address 172.16.255.253; }
host reserva100 { hardware ethernet 08:00:27:BB:BB:A0; fixed-address 172.16.255.254; }
```

Reinicia y valida:

```bash
sudo systemctl restart isc-dhcp-server
sudo systemctl status isc-dhcp-server
sudo journalctl -u isc-dhcp-server -n 50 --no-pager
```

> La IP del servidor se “reserva de la asignación” dejándola estática y fuera de rangos dinámicos.

---

## Actividad 3 (unir clientes al dominio)

### 1) CW1001 al dominio de ServidorWindows (gráfico)

1. Clona enlazada desde plantilla CW10XX.
2. Cambia:
   - Nombre de equipo (`CW1001`),
   - MAC de la NIC,
   - IP (si estática) o DHCP.
3. Configura DNS del cliente apuntando a `192.168.100.100`.
4. Comprueba:
   - `ping servidorwindows.miempresafea.local`
   - `nslookup miempresafea.local`
5. Une al dominio:
   - `Sistema -> Cambiar configuración -> Cambiar -> Dominio`.
   - Introduce `miempresafea.local` y credenciales con permisos.
6. Reinicia e inicia sesión con `MIEMPRESAFEA\usuario`.

### 2) CU1801 (clon) al dominio de ServidorUbuntu (CLI)

1. Clona enlazada desde CU18XX y cambia hostname/MAC/IP.
2. Configura DNS del cliente a `10.0.3.3`.
3. Instala paquetes:

```bash
sudo apt update
sudo apt install realmd sssd-ad sssd-tools adcli krb5-user samba-common-bin libpam-mkhomedir packagekit -y
```

4. Descubre y une dominio:

```bash
sudo realm discover miempresafea.local
sudo realm join miempresafea.local -U Administrador
realm list
```

5. Habilita home automático y acceso:

```bash
sudo pam-auth-update --enable mkhomedir
sudo realm permit --groups "Domain Users"
```

6. Pruebas:

```bash
id usuario@miempresafea.local
getent passwd usuario@miempresafea.local
klist
```

---

## Actividad 4 (administración remota)

### 1) RSAT en CW1001 para administrar ServidorWindows (gráfico)

1. En Windows cliente abre `Configuración -> Aplicaciones -> Características opcionales`.
2. Instala herramientas RSAT necesarias (AD DS, DNS, DHCP, etc.).
3. Abre `Administrador del servidor` y agrega `ServidorWindows`.
4. Comprueba que puedes gestionar DNS/DHCP/AD remotamente.

### 2) OpenSSH Client en CW1002 hacia ServidorUbuntu

En CW1002 (PowerShell admin):

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
ssh administrador@10.0.3.3
```

Prueba tarea administrativa remota:

```bash
sudo systemctl status ssh
sudo apt update
```

### 3) SSH en CU1801 hacia ServidorUbuntu

```bash
sudo apt update
sudo apt install openssh-client -y
ssh administrador@10.0.3.3
```

Si necesitas también que Ubuntu reciba conexiones:

```bash
sudo apt install openssh-server -y
sudo systemctl enable --now ssh
sudo ss -tulpen | grep :22
```

---

## Actividad 5 (refuerzo) — solución guiada

- DNS CNAME `Publicaciones` y `Proxy` (Proxy apuntando a host inexistente):
  - `nslookup publicaciones.miempresafea.local` debe resolver al servidor real.
  - `nslookup proxy.miempresafea.local` resuelve a IP no válida si existe el registro A inventado.
  - Es lógico que resolución DNS funcione pero conectividad falle si destino no existe.
- DHCP segundo ámbito de respaldo:
  - Excluir la última IP evita asignar broadcast o IP reservada.
  - Concesión 8h = tiempo de validez de la IP antes de renovar.
  - Cambia gateway del ámbito en Opciones de ámbito.
  - Desactiva ámbito viejo, activa nuevo, renueva cliente (`ipconfig /renew` o `dhclient`).
- OpenSSH cruzado Win<->Linux:
  - Windows Server OpenSSH + regla firewall TCP/22.
  - Linux cliente con `openssh-client` para conectar a Windows.
  - Linux con `openssh-server` para conectar desde Windows (`ssh usuario@ip_linux`).

---

## Actividad 6 (ampliación) — propuesta de solución

1. **Superámbito DHCP**: agrupación lógica de varios ámbitos en un mismo servidor DHCP para gestionar varias subredes físicas/lógicas como un conjunto.
2. Crea dos ámbitos (ejemplo):
   - Contabilidad: `192.168.10.50-192.168.10.199`
   - TIC: `192.168.20.50-192.168.20.199`
3. Crea superámbito `Empresa` que incluya ambos.
4. Une CU1801 a ServidorUbuntu y clon a ServidorWindows usando `realmd+sssd` (o LikeWise si te lo piden explícitamente).
5. RSAT en CW1001 clonado para administrar servicios del entorno; si el servidor Ubuntu es Samba AD, la administración avanzada se hace mejor con `samba-tool`/MMC compatibles.

---

## Evidencias que debes capturar (para Moodle)

1. DNS: registros A, CNAME y zona inversa creados + pruebas `nslookup`/`ping`.
2. DHCP Windows y Ubuntu: ámbitos, reservas, exclusiones, concesión y estado servicio.
3. Unión al dominio: pantalla de unión correcta + `realm list`/inicio sesión dominio.
4. Administración remota: RSAT funcionando + sesión SSH abierta y comando admin ejecutado.
