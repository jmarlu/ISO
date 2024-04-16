# Estándares.

## ¿Qué son CIM y WMI?

CIM (Common Information Model) es un estándar abierto creado por la organización DMTF orientado a proveer una definición común para el intercambio de información entre sistemas, redes, aplicaciones y servicios.

WMI (Windows Management Instrumentation) es la implementación de Microsoft de CIM, con la que se proveen métodos para consultar y modificar la configuración de una máquina Window.

Aunque esta definido anteriormente como un estándar abierto, actualmente es el nombre de la implementación . Por lo tanto:

Los cmdlets Wmi fueron los que aparecieron primero\* pero a partir de Windows PowerShell 3 fueron sustituidos por los CimCmdlets.

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
