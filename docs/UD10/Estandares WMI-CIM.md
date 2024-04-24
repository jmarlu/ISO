# Estándares.

## ¿Qué son CIM y WMI?

CIM (Common Information Model) es un estándar abierto creado por la organización DMTF orientado a proveer una definición común para el intercambio de información entre sistemas, redes, aplicaciones y servicios.

WMI (Windows Management Instrumentation) es la implementación de Microsoft de CIM, con la que se proveen métodos para consultar y modificar la configuración de una máquina Window.

Aunque esta definido anteriormente como un estándar abierto, actualmente es el nombre de la implementación . Por lo tanto:

Los cmdlets Wmi fueron los que aparecieron primero pero a partir de Windows PowerShell 3 fueron sustituidos por los CimCmdlets.

## Descubrir las clases que soporta.

`Get-CimClass` es **EL** comando elegido para descubrir todo lo que se esconde en una infraestructura
CIM/WMI ya que el descubrimiento era hasta ahora el gran punto débil de esta tecnología.

Veamos un ejemplo:

```PowerShell title="Filtrar clases"
 Get-CimClass -ClassName *network*
>>


   NameSpace: ROOT/cimv2

CimClassName                        CimClassMethods      CimClassProperties
------------                        ---------------      ------------------
Win32_NetworkLoginProfile           {}                   {Caption, Description, SettingID, AccountExpires...}
Win32_NetworkAdapterConfiguration   {EnableDHCP, Rene... {Caption, Description, SettingID, ArpAlwaysSourceRoute...}
Win32_NetworkAdapterSetting         {}                   {Element, Setting}
```

Pero podemos, también las propiedades y métodos.

```PowerShell title=""
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT>  (Get-CimClass -ClassName Win32_NetworkAdapterConfiguration).
>> CimClassProperties | Select-Object Name
>>

Name
----
Caption
Description
SettingID

```

También podemos buscar clases que tengan una propiedad o método en concreto.

```PowerShell title=""
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT>  Get-CimClass -PropertyName speed


   NameSpace: ROOT/cimv2

CimClassName                        CimClassMethods      CimClassProperties
------------                        ---------------      ------------------
CIM_NetworkAdapter                  {SetPowerState, R... {Caption, Description, InstallDate, Name...}
Win32_NetworkAdapter                {SetPowerState, R... {Caption, Description, InstallDate, Name...}
```

## Recuperar las instancias de esas clases.

Ya hemos visto que tipos hay. Ahora debemos recuperar el objeto o instancia perteneciente a una clase en concreto.

Veamoslo en el siguiente ejemplo.

```PowerShell title=""
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT> Get-CimInstance -ClassName Win32_BIOS


SMBIOSBIOSVersion : VirtualBox
Manufacturer      : innotek GmbH
Name              : Default System BIOS
SerialNumber      : 0
Version           : VBOX   - 1
```

## Recuperar con un filtro QL/CQL

Cuando una consulta CIM/WMI devuelve un gran número de objetos, es preferible utilizar (con `Where-Object`).

```PowerShell title=""

```

## Comandos de la familia WMI

Como hemos dicho anteriormente el conjunto de comandos WMI ha sido sustituido por los comandos de la familia CIM.
Aunque hay muchos scripts que poseen dichos comandos. Por ejemplo, el comando `Get-CimInstance` tienes como equivalente a `get-wmiObject`

## Establecer sesiones con equipos remotos

Mientras que los comando WMI se comunicaban con máquinas remotas mediante los protocolos DCOM y RPC. Éstas, no eran óptimas dado que la sesión se elimina después de haber devuelto los resultados.

Sin embargo, los comandos de la familia CIM mejoran enormemente esta comunicación aportando:

- Una comunicación que permite eligir entre los protocolos HTTPS/WS-Man o DCOM/RPC.
- La posibilidad de mantener una sesión entre el cliente y los servidores.
- La posibilidad de enviar consultas de manera paralela y no secuencial.
- Un mecanismo de « remoting » similar a las sesiones PowerShell remotas.

Para el siguiente ejemplo tenemos un Windows server con un dominio y un windows 10 añadido al dominio de tal manera que consultamos desde un ordenador a otro. el nombre de la computadora y el dia que instaló el sistema operativo y su versión.

```PowerShell title=""
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT> $s = New-CimSession -ComputerName localhost, cliente2
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT> Get-CimInstance -ClassName Win32_operatingSystem -CimSession $s |
>> Select-Object PSComputerName, Installdate, Version, Caption

PSComputerName Installdate         Version    Caption
-------------- -----------         -------    -------
localhost      06/10/2023 8:55:15  10.0.20348 Microsoft Windows Server 2022 Standard
cliente2       15/03/2022 18:27:37 10.0.19044 Microsoft Windows 10 Education


```

Este ejemplo lo he realizado desde el Windows Server dado que tenemos un usuario administrador del dominio. Se puede realizar al contrario, pero tenemos que cambiar la credencial.

Podemos también, quitar todas las conexiones que hemos establecido anteriormente mediante.

```PowerShell title=""
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT> Get-CimSession


Id           : 1
Name         : CimSession1
InstanceId   : d92a043e-ff09-4abb-9fe1-dc53a7678539
ComputerName : cliente2
Protocol     : WSMAN

Id           : 2
Name         : CimSession2
InstanceId   : ec1f236f-d97a-4efb-a18f-ad788b8e7f45
ComputerName : localhost
Protocol     : WSMAN



PS C:\Users\Administrador.WIN-OT4FJF7Q1AT> Get-CimSession | Remove-CimSession
>>
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT> Get-CimSession
PS C:\Users\Administrador.WIN-OT4FJF7Q1AT>
```

## Gestionar o monitorizar eventos\.

Es una herramienta muy útil de CIM/WMI que permite vigilar eventos (click, ejecución de procesos, etc.. ).

Para suscribirnos a un evento, por ejemplo a la creación de proceso.El comando PowerShell clave para llevar a cabo esta
operación es `Register-CimIndicationEvent`.

Vamos a ver un ejemplo en el que se monitoriza la ejecución del paint y cuando se genera su

```PowerShell title="Script Mpaint.exe"
$action = {
$mesg = "El proceso ha sido arrancado el {0} !" -f (ConvertTo-LocalTime `
-LongDate $event.SourceEventArgs.NewEvent.Time_Created)
Write-Warning $mesg
}
$query = "SELECT * FROM __InstanceCreationEvent
WITHIN 3 WHERE Targetinstance ISA ’Win32_process’
AND TargetInstance.Name='mspaint.exe'"
Register-CimIndicationEvent -Query $query -SourceIdentifier "PaintWatcher" `
-Action $action

```
