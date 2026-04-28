# Repaso UD10: PowerShell desde Bash

## Objetivo de la sesión

Repaso del tema, puntos a tocar:

- cmdlets, alias y ayuda.
- tuberías y objetos.
- variables, parámetros y entrada por teclado.
- operadores.
- estructuras condicionales e iterativas.
- vectores y funciones.
- primeros scripts de administración.

> Nota: desde Bash se puede preparar y lanzar PowerShell si está instalado como `pwsh`. Si no está instalado, los scripts se pueden crear igualmente, pero deberán ejecutarse en Windows PowerShell o en PowerShell 7.

## Instalación de PowerShell (`pwsh`) en Ubuntu

PowerShell 7 se puede usar en Linux con el comando `pwsh`. Para esta unidad interesa instalarlo porque permite crear y ejecutar scripts `.ps1` directamente desde Bash.

Fuente oficial de Microsoft: <https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu>

### Instalación recomendada desde repositorio Microsoft

Este método es el recomendado por Microsoft para versiones de Ubuntu soportadas, como Ubuntu 22.04 LTS y Ubuntu 24.04 LTS.

No usar este método como primera opción en Ubuntu 25.10. Puede aparecer este error:

```text
E: El paquete «powershell» no tiene un candidato para la instalación
```

Ese mensaje significa que `apt` conoce los repositorios configurados, pero no encuentra un paquete `powershell` instalable para esa versión de Ubuntu. En ese caso hay que usar la instalación manual con `.deb`.

Ejecutar en Bash:

```bash
sudo apt-get update
sudo apt-get install -y wget apt-transport-https software-properties-common

source /etc/os-release
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update
sudo apt-get install -y powershell
```

Comprobar la instalación:

```bash
command -v pwsh
pwsh --version
```

Entrar en PowerShell:

```bash
pwsh
```

Salir de PowerShell y volver a Bash:

```powershell
exit
```

### Instalación manual con paquete `.deb`

Si se usa una versión de Ubuntu no soportada por el repositorio, por ejemplo Ubuntu 25.10, Microsoft recomienda usar la instalación manual con el paquete universal `.deb`.

Este es el método que se debe usar si aparece:

```text
E: El paquete «powershell» no tiene un candidato para la instalación
```

Ejemplo con PowerShell 7.6 LTS:

```bash
sudo apt-get update
sudo apt-get install -y wget

wget https://github.com/PowerShell/PowerShell/releases/download/v7.6.1/powershell_7.6.1-1.deb_amd64.deb
sudo dpkg -i powershell_7.6.1-1.deb_amd64.deb
sudo apt-get install -f -y
rm powershell_7.6.1-1.deb_amd64.deb
```

Ejemplo con PowerShell 7.5 estable:

```bash
sudo apt-get update
sudo apt-get install -y wget

wget https://github.com/PowerShell/PowerShell/releases/download/v7.5.6/powershell_7.5.6-1.deb_amd64.deb
sudo dpkg -i powershell_7.5.6-1.deb_amd64.deb
sudo apt-get install -f -y
rm powershell_7.5.6-1.deb_amd64.deb
```

Comprobar después:

```bash
pwsh --version
pwsh -Command 'Write-Host "PowerShell funciona"; Get-Date'
```

### Desinstalación

```bash
sudo apt-get remove powershell
```

## Preparación desde Bash


Comprobar si PowerShell está instalado:

```bash
command -v pwsh
pwsh --version
```

Crear una carpeta de trabajo para la clase:

```bash
mkdir -p ~/repaso-ud10
cd ~/repaso-ud10
```

Ejecutar un script si existe `pwsh`:

```bash
pwsh ./script.ps1
```

Ejecutar un comando suelto:

```bash
pwsh -Command 'Get-Process | Sort-Object Id | Select-Object -First 5'
```

## Diferencias entre Bash y PowerShell

Bash y PowerShell sirven para trabajar desde linea de comandos y automatizar tareas, pero no funcionan igual por dentro.

La diferencia principal es esta:

- Bash trabaja principalmente con texto.
- PowerShell trabaja principalmente con objetos.

En Bash, cuando un comando envia informacion a otro mediante una tuberia, normalmente envia lineas de texto. En PowerShell, cuando un comando envia informacion a otro, envia objetos con propiedades y metodos.

Ejemplo en Bash:

```bash
ps aux | grep bash
```

Aqui `ps aux` produce texto y `grep` busca dentro de ese texto.

Ejemplo equivalente en PowerShell:

```powershell
Get-Process | Where-Object {$_.Name -like "*bash*"}
```

Aqui `Get-Process` produce objetos de procesos. `Where-Object` no busca en texto plano, sino que comprueba la propiedad `Name` de cada proceso.

### Comparacion rapida

| Aspecto | Bash | PowerShell |
| --- | --- | --- |
| Tipo de shell | Shell tradicional Unix/Linux | Shell orientada a objetos |
| Salida normal | Texto | Objetos |
| Tuberia | Pasa texto | Pasa objetos |
| Variables | Normalmente cadenas de texto | Pueden tener tipo: `int`, `string`, `bool`, etc. |
| Comandos | `ls`, `cp`, `rm`, `cat` | `Get-ChildItem`, `Copy-Item`, `Remove-Item`, `Get-Content` |
| Sintaxis de opciones | `-l`, `-a`, `--help` | `-Name`, `-Path`, `-Recurse` |
| Comparaciones | `-eq`, `-gt` dentro de `[` o `[[` | `-eq`, `-gt`, `-like` directamente |
| Condicional | `if [ condicion ]; then ... fi` | `if (condicion) { ... }` |
| Bucle | `for x in lista; do ... done` | `foreach ($x in $lista) { ... }` |
| Script | `.sh` | `.ps1` |

### Variables en Bash

En Bash se asigna una variable sin espacios alrededor del signo `=`:

```bash
nombre="Ana"
edad=20
```

Para usar el valor se antepone `$`:

```bash
echo "$nombre"
echo "$edad"
```

Aunque `edad=20` parece un numero, Bash lo trata normalmente como texto. Para hacer calculos se usa expansion aritmetica:

```bash
a=10
b=5
echo $((a + b))
```

Error frecuente en Bash:

```bash
nombre = "Ana"
```

Eso esta mal porque Bash interpreta `nombre` como si fuera un comando. Lo correcto es:

```bash
nombre="Ana"
```

### Variables en PowerShell

En PowerShell las variables siempre empiezan por `$`, tanto al asignar como al leer:

```powershell
$nombre = "Ana"
$edad = 20
```

Para mostrar:

```powershell
Write-Host $nombre
Write-Host $edad
```

PowerShell puede deducir el tipo automaticamente:

```powershell
$numero = 10
$texto = "10"
```

Comprobar el tipo:

```powershell
$numero.GetType().Name
$texto.GetType().Name
```

Salida esperada:

```text
Int32
String
```

Tambien se puede declarar el tipo de forma explicita:

```powershell
[int]$edad = 20
[string]$nombre = "Ana"
[bool]$activo = $true
[double]$precio = 19.95
```

Esto es una diferencia importante frente a Bash. En PowerShell, si una variable es `[int]`, PowerShell intenta tratarla como numero.

Ejemplo:

```powershell
[int]$a = 10
[int]$b = 5
Write-Host ($a + $b)
```

Salida:

```text
15
```

En Bash:

```bash
a=10
b=5
echo "$a$b"
```

Salida:

```text
105
```

Para sumar en Bash:

```bash
echo $((a + b))
```

### Diferencia al concatenar texto

En Bash:

```bash
nombre="Ana"
echo "Hola $nombre"
```

En PowerShell:

```powershell
$nombre = "Ana"
Write-Host "Hola $nombre"
```

En ambos casos las comillas dobles expanden variables. Las comillas simples no expanden:

```powershell
$nombre = "Ana"
Write-Host 'Hola $nombre'
```

Salida:

```text
Hola $nombre
```

### Argumentos de scripts

En Bash se usan `$1`, `$2`, `$3`:

```bash
#!/bin/bash
echo "Primer argumento: $1"
echo "Segundo argumento: $2"
```

Ejecucion:

```bash
./script.sh uno dos
```

En PowerShell se puede usar `$args`:

```powershell
Write-Host "Primer argumento: $($args[0])"
Write-Host "Segundo argumento: $($args[1])"
```

Pero es mas claro usar `param`:

```powershell
param (
    [string]$nombre,
    [int]$edad
)

Write-Host "Nombre: $nombre"
Write-Host "Edad: $edad"
```

Ejecucion desde Bash:

```bash
pwsh ./script.ps1 -nombre Ana -edad 20
```

### Tuberias: texto frente a objetos

En Bash:

```bash
ls -l | grep ".txt"
```

El segundo comando recibe texto.

En PowerShell:

```powershell
Get-ChildItem | Where-Object {$_.Extension -eq ".txt"}
```

El segundo comando recibe objetos de archivo. Por eso se puede filtrar por propiedades como:

```powershell
$_.Name
$_.Length
$_.Extension
$_.LastWriteTime
```

Para ver las propiedades disponibles:

```powershell
Get-ChildItem | Get-Member
```

### Equivalencias utiles

| Bash | PowerShell |
| --- | --- |
| `pwd` | `Get-Location` |
| `cd ruta` | `Set-Location ruta` |
| `ls` | `Get-ChildItem` |
| `cat fichero` | `Get-Content fichero` |
| `cp origen destino` | `Copy-Item origen destino` |
| `mv origen destino` | `Move-Item origen destino` |
| `rm fichero` | `Remove-Item fichero` |
| `mkdir carpeta` | `New-Item -ItemType Directory carpeta` |
| `grep texto fichero` | `Select-String texto fichero` |
| `ps` | `Get-Process` |

### Idea clave para recordar

En Bash se suele pensar:

```text
comando -> texto -> filtro de texto
```

En PowerShell se debe pensar:

```text
cmdlet -> objeto -> propiedad -> filtro
```

## Contenido esencial

### Cmdlets

Los comandos propios de PowerShell se llaman `cmdlets`. Suelen tener la forma:

```powershell
Verbo-Nombre
```

Ejemplos:

```powershell
Get-Process
Get-Service
Get-ChildItem
New-Item
Copy-Item
Remove-Item
```

### Ayuda

```powershell
Get-Help Get-Process
Get-Help Get-Process -Examples
Get-Command
Get-Command -Verb Get
```

### Alias

PowerShell permite usar alias parecidos a comandos de Bash o CMD, pero no todos existen en todas las instalaciones. Por ejemplo, `dir` suele existir como alias de `Get-ChildItem`, pero `ls` puede no existir en algunas instalaciones de PowerShell sobre Linux.

```powershell
dir
cd
cat
```

Para ver qué cmdlet hay detrás:

```powershell
Get-Alias dir
Get-Alias cd
Get-Alias cat
```

Para comprobar si existe un alias sin provocar un error:

```powershell
Get-Alias ls -ErrorAction SilentlyContinue
```

Si `ls` no existe, se puede usar directamente el cmdlet:

```powershell
Get-ChildItem
```

### Objetos

En Bash la tubería suele pasar texto. En PowerShell la tubería pasa objetos.

```powershell
Get-Process | Get-Member
```

Ejemplo de acceso a propiedades:

```powershell
$procesos = Get-Process
$procesos[0].Name
$procesos[0].Id
```

### Tuberías

```powershell
Get-Process | Sort-Object Id
Get-Process | Select-Object -Property Name, Id, CPU | Format-Table -AutoSize
Get-Service | Where-Object {$_.Name -like "n*"}
```

Si solo aparece `Name`, normalmente no es que falten las propiedades. Lo habitual en Linux es que haya procesos con nombres muy largos y PowerShell decida ajustar la salida automaticamente mostrando solo la columna que cabe en pantalla.

Para una clase, limitar la salida con `-First`:

```powershell
Get-Process | Select-Object -First 5 -Property Name, Id, CPU | Format-Table -AutoSize
```

O forzar tabla con ajuste de texto:

```powershell
Get-Process | Select-Object -Property Name, Id, CPU | Format-Table -Wrap
```

Otra opción más limpia es ordenar y quedarse con pocos procesos:

```powershell
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 -Property Name, Id, CPU | Format-Table -AutoSize
```

Para comprobar que las propiedades existen:

```powershell
Get-Process | Select-Object -First 1 | Get-Member -MemberType Property
```

No escribir punto al final de la propiedad. Esto crea una columna llamada `CPU.` y no mostrara el valor correcto:

```powershell
Get-Process | Select-Object Name, Id, CPU.
```

La forma correcta es:

```powershell
Get-Process | Select-Object Name, Id, CPU
```

### Variables

```powershell
$nombre = "Ana"
[int]$edad = 20
[double]$precio = 19.95
[bool]$activo = $true
```

Ver el tipo:

```powershell
$edad.GetType().Name
```

### Entrada y salida

```powershell
$nombre = Read-Host "Introduce tu nombre"
Write-Host "Hola $nombre"
```

### Parámetros

Con `$args`:

```powershell
$nombre = $args[0]
Write-Host "Hola $nombre"
```

Con `param`, forma más recomendable:

```powershell
param ([string]$nombre)
Write-Host "Hola $nombre"
```

### Operadores

Aritméticos:

```powershell
$a + $b
$a - $b
$a * $b
$a / $b
$a % $b
```

Comparación:

```powershell
$a -eq $b
$a -ne $b
$a -gt $b
$a -ge $b
$a -lt $b
$a -le $b
```

Lógicos:

```powershell
($a -gt 0) -and ($b -gt 0)
($a -gt 0) -or ($b -gt 0)
-not ($a -eq $b)
```

## Soluciones de actividades básicas

### 1. Procesos del sistema ordenados por ID

Archivo: `ej101.ps1`

```powershell
Get-Process | Sort-Object Id | Select-Object -Property Id, ProcessName, CPU | Format-Table -AutoSize
```

Ejecución:

```bash
pwsh ./ej101.ps1
```

### 2. Servicios cuyo nombre empieza por `n`

Archivo: `ej102.ps1`

```powershell
Get-Process | Where-Object {$_.Name -like "n*"} | Select-Object Name, Status, DisplayName
```

### 3. Script con dos números como argumentos

Archivo: `ej103.ps1`

```powershell
param (
    [int]$a,
    [int]$b
)

Write-Host "Primer numero: $a"
Write-Host "Segundo numero: $b"
```

Ejecución:

```bash
pwsh ./ej103.ps1 10 20
```

### 4. Script que pide dos números al usuario

Archivo: `ej104.ps1`

```powershell
[int]$a = Read-Host "Introduce el primer numero"
[int]$b = Read-Host "Introduce el segundo numero"

Write-Host "Primer numero: $a"
Write-Host "Segundo numero: $b"
```

### 5. Operaciones con tres variables

Archivo: `ej105.ps1`

```powershell
[int]$a = Read-Host "Introduce a"
[int]$b = Read-Host "Introduce b"
[int]$c = Read-Host "Introduce c"

if ($b -eq 0 -or $c -eq 0) {
    Write-Host "No se puede dividir entre cero."
    exit
}

Write-Host "a % b = " ($a % $b)
Write-Host "a / c = " ($a / $c)
Write-Host "2 * b + 3 * (a - c) = " (2 * $b + 3 * ($a - $c))
Write-Host "a * (b / c) = " ($a * ($b / $c))
Write-Host "(a * c) % b = " (($a * $c) % $b)
```

## Soluciones de control de flujo

### 6. Comprobar si no se pasa ningún argumento

Archivo: `ej106.ps1`

```powershell
if ($args.Length -eq 0) {
    Write-Host "No se ha pasado ningun argumento."
} else {
    Write-Host "Argumentos recibidos:"
    foreach ($arg in $args) {
        Write-Host "- $arg"
    }
}
```

Ejecución:

```bash
pwsh ./ej106.ps1
pwsh ./ej106.ps1 uno dos tres
```

### 7. Saludo según la hora del sistema

Archivo: `ej107.ps1`

```powershell
$hora = (Get-Date).Hour

if ($hora -ge 8 -and $hora -lt 15) {
    Write-Host "Buenos dias"
} elseif ($hora -ge 15 -and $hora -lt 20) {
    Write-Host "Buenas tardes"
} else {
    Write-Host "Buenas noches"
}
```

### 8A. Tabla de multiplicar

Archivo: `ej208A.ps1`

```powershell
[int]$numero = Read-Host "Introduce un numero entero positivo"

if ($numero -le 0) {
    Write-Host "El numero debe ser entero positivo."
    exit
}

for ($i = 1; $i -le 10; $i++) {
    Write-Host "$i x $numero =" ($i * $numero)
}
```

### 8B. Número par y número primo

Archivo: `ej208B.ps1`

```powershell
[int]$numero = Read-Host "Introduce un numero entero positivo"

if ($numero -le 0) {
    Write-Host "El numero debe ser entero positivo."
    exit
}

if ($numero % 2 -eq 0) {
    Write-Host "$numero es par"
} else {
    Write-Host "$numero es impar"
}

$esPrimo = $true

if ($numero -lt 2) {
    $esPrimo = $false
} else {
    for ($i = 2; $i -le [math]::Sqrt($numero); $i++) {
        if ($numero % $i -eq 0) {
            $esPrimo = $false
            break
        }
    }
}

if ($esPrimo) {
    Write-Host "$numero es primo"
} else {
    Write-Host "$numero no es primo"
}
```

### 8C. Diez primeras tablas de multiplicar

Archivo: `ej208C.ps1`

```powershell
for ($tabla = 1; $tabla -le 10; $tabla++) {
    Write-Host "Tabla del $tabla"

    for ($i = 1; $i -le 10; $i++) {
        Write-Host "$i x $tabla =" ($i * $tabla)
    }

    Start-Sleep -Seconds 1
}
```

Versión con `foreach`:

```powershell
foreach ($tabla in 1..10) {
    Write-Host "Tabla del $tabla"

    foreach ($i in 1..10) {
        Write-Host "$i x $tabla =" ($i * $tabla)
    }

    Start-Sleep -Seconds 1
}
```

## Soluciones de vectores y funciones

### 9. Vector con 365 temperaturas

Archivo: `ej109.ps1`

```powershell
$temperaturas = @()

for ($i = 1; $i -le 365; $i++) {
    $temperaturas += Get-Random -Minimum -5 -Maximum 36
}

$suma = 0

foreach ($temperatura in $temperaturas) {
    $suma += $temperatura
}

$media = $suma / $temperaturas.Length
$porEncima = 0
$porDebajo = 0
$igual = 0

foreach ($temperatura in $temperaturas) {
    if ($temperatura -gt $media) {
        $porEncima++
    } elseif ($temperatura -lt $media) {
        $porDebajo++
    } else {
        $igual++
    }
}

Write-Host "Media: $media"
Write-Host "Dias por encima de la media: $porEncima"
Write-Host "Dias por debajo de la media: $porDebajo"
Write-Host "Dias iguales a la media: $igual"
```

Versión más compacta:

```powershell
$temperaturas = 1..365 | ForEach-Object { Get-Random -Minimum -5 -Maximum 36 }
$media = ($temperaturas | Measure-Object -Average).Average

$porEncima = ($temperaturas | Where-Object {$_ -gt $media}).Count
$porDebajo = ($temperaturas | Where-Object {$_ -lt $media}).Count
$igual = ($temperaturas | Where-Object {$_ -eq $media}).Count

Write-Host "Media: $media"
Write-Host "Dias por encima: $porEncima"
Write-Host "Dias por debajo: $porDebajo"
Write-Host "Dias iguales: $igual"
```

### 10. Copia de seguridad con funciones

Archivo: `ej110_backup.ps1`

```powershell
param (
    [string]$Origen = $HOME,
    [string]$Destino = "$HOME/BackupPS"
)

function New-BackupDirectory {
    param ([string]$Ruta)

    if (-not (Test-Path $Ruta)) {
        New-Item -ItemType Directory -Path $Ruta | Out-Null
    }
}

function Test-ShouldCopy {
    param (
        [System.IO.FileInfo]$ArchivoOrigen,
        [string]$ArchivoDestino
    )

    if (-not (Test-Path $ArchivoDestino)) {
        return $true
    }

    $destinoInfo = Get-Item $ArchivoDestino

    if ($ArchivoOrigen.LastWriteTime -gt $destinoInfo.LastWriteTime) {
        return $true
    }

    if ($ArchivoOrigen.Length -gt $destinoInfo.Length) {
        return $true
    }

    return $false
}

function Write-BackupLog {
    param (
        [string]$Mensaje,
        [string]$LogPath
    )

    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogPath -Value "$fecha - $Mensaje"
}

New-BackupDirectory -Ruta $Destino

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$logPath = Join-Path $scriptDir "backup.log"

Get-ChildItem -Path $Origen -File | ForEach-Object {
    $archivoDestino = Join-Path $Destino $_.Name

    if (Test-ShouldCopy -ArchivoOrigen $_ -ArchivoDestino $archivoDestino) {
        Copy-Item -Path $_.FullName -Destination $archivoDestino -Force
        Write-BackupLog -Mensaje "Copiado: $($_.FullName) -> $archivoDestino" -LogPath $logPath
    } else {
        Write-BackupLog -Mensaje "No copiado: $($_.FullName)" -LogPath $logPath
    }
}
```

Ejecución:

```bash
pwsh ./ej110_backup.ps1
pwsh ./ej110_backup.ps1 -Origen "$HOME/Documentos" -Destino "$HOME/BackupPS"
```

## Soluciones de administración

Estas soluciones requieren un entorno Windows con Active Directory, permisos adecuados y módulos disponibles. No son adecuadas para una demo rápida en Bash sin dominio.

### 11. Listar equipos del dominio y comprobar conectividad

Archivo: `scriptAd1.ps1`

```powershell
Import-Module ActiveDirectory

$equipos = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

foreach ($equipo in $equipos) {
    if (Test-Connection $equipo -Quiet -Count 1) {
        [PSCustomObject]@{
            Equipo = $equipo
            Estado = "alcanzado"
        }
    } else {
        [PSCustomObject]@{
            Equipo = $equipo
            Estado = "no alcanzado"
        }
    }
}
```

### 12. Memoria virtual del proceso PowerShell en equipos remotos

Archivo: `scriptProcesVirtual.ps1`

```powershell
Import-Module ActiveDirectory

$equipos = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

foreach ($equipo in $equipos) {
    if (Test-Connection $equipo -Quiet -Count 1) {
        $proceso = Get-Process -ComputerName $equipo -Name powershell -ErrorAction SilentlyContinue |
            Select-Object -First 1

        if ($proceso) {
            [PSCustomObject]@{
                Equipo = $equipo
                MemoriaVirtual = $proceso.VirtualMemorySize
            }
        } else {
            [PSCustomObject]@{
                Equipo = $equipo
                MemoriaVirtual = "proceso no encontrado"
            }
        }
    } else {
        [PSCustomObject]@{
            Equipo = $equipo
            MemoriaVirtual = "no alcanzado"
        }
    }
}
```

### 13. Versión de Media Player mediante registro

Archivo: `scriptMediaPlayerVersion.ps1`

```powershell
Import-Module ActiveDirectory

function Get-Key {
    $ruta = "HKLM:\SOFTWARE\Microsoft\MediaPlayer\PlayerUpgrade"
    $valor = Get-ItemProperty $ruta -Name "PlayerVersion" -ErrorAction SilentlyContinue

    if ($valor) {
        return $valor.PlayerVersion
    }

    return "no instalado"
}

$equipos = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

foreach ($equipo in $equipos) {
    if (Test-Connection $equipo -Quiet -Count 1) {
        $version = Invoke-Command -ComputerName $equipo -ScriptBlock ${function:Get-Key}

        [PSCustomObject]@{
            Equipo = $equipo
            Version = $version
        }
    } else {
        [PSCustomObject]@{
            Equipo = $equipo
            Version = "equipo inalcanzable"
        }
    }
}
```

### 14. Obtener configuración DNS

Archivo: `scriptDNSConfig.ps1`

```powershell
function Get-DNSConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]$ComputerName
    )

    process {
        foreach ($equipo in $ComputerName) {
            if (Test-Connection $equipo -Quiet -Count 1) {
                $adaptadores = Get-WmiObject -Class Win32_NetworkAdapterConfiguration `
                    -ComputerName $equipo `
                    -Filter "IPEnabled = True"

                foreach ($adaptador in $adaptadores) {
                    [PSCustomObject]@{
                        HostName = $equipo
                        Ping = "OK"
                        DNS = $adaptador.DNSServerSearchOrder
                    }
                }
            } else {
                [PSCustomObject]@{
                    HostName = $equipo
                    Ping = "NOK"
                    DNS = $null
                }
            }
        }
    }
}
```

Uso:

```powershell
Get-DNSConfiguration -ComputerName cliente2

Get-ADComputer -Filter * |
    Select-Object -ExpandProperty Name |
    Get-DNSConfiguration
```

### 15. Asignar DNS

Archivo: `scriptSetDNSConfig.ps1`

```powershell
function Set-DNSConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]$ComputerName,

        [string[]]$DNSList = @("192.168.0.30", "192.168.0.40")
    )

    process {
        foreach ($equipo in $ComputerName) {
            if (Test-Connection $equipo -Quiet -Count 1) {
                $adaptadores = Get-WmiObject -Class Win32_NetworkAdapterConfiguration `
                    -ComputerName $equipo `
                    -Filter "IPEnabled = True"

                foreach ($adaptador in $adaptadores) {
                    $resultado = $adaptador.SetDNSServerSearchOrder($DNSList)

                    [PSCustomObject]@{
                        HostName = $equipo
                        Ping = "OK"
                        DNS = $DNSList
                        Resultado = $resultado.ReturnValue
                    }
                }
            } else {
                [PSCustomObject]@{
                    HostName = $equipo
                    Ping = "NOK"
                    DNS = $null
                    Resultado = "equipo inalcanzable"
                }
            }
        }
    }
}
```

Uso:

```powershell
Set-DNSConfiguration -ComputerName cliente2
Set-DNSConfiguration -ComputerName cliente2 -DNSList "192.168.1.30", "192.168.1.40"
```

### 16. Crear usuarios desde CSV

Archivo CSV de ejemplo: `usuarios.csv`

```csv
Name;SAMAccountName;givenName;surname;Description;profilePath;scriptPath;HomeDrive;HomeDirectory
Perez;Perez;Eduardo;Perez;Cuenta de usuario;;login.vbs;L:;\\srvfic1\users
Larea;Larea;Pedro;Larea;Cuenta de usuario;;login.vbs;L:;\\srvfic1\users
Gonzalo;Gonzalo;Juan;Gonzalo;Cuenta de usuario;;login.vbs;L:;\\srvfic1\users
Arellano;Arellano;Marcelo;Arellano;Cuenta de usuario;;login.vbs;L:;\\srvfic1\users
Navarro;Navarro;Jorge;Navarro;Cuenta de usuario;;login.vbs;L:;\\srvfic1\users
```

Archivo: `scriptNewUser.ps1`

```powershell
Import-Module ActiveDirectory

$usuarios = Import-Csv -Path ".\usuarios.csv" -Delimiter ";"
$ou = "OU=Usuarios,DC=empresa,DC=local"
$password = ConvertTo-SecureString "Cambiar1234!" -AsPlainText -Force

foreach ($usuario in $usuarios) {
    New-ADUser `
        -Name $usuario.Name `
        -SamAccountName $usuario.SAMAccountName `
        -GivenName $usuario.givenName `
        -Surname $usuario.surname `
        -Description $usuario.Description `
        -ProfilePath $usuario.profilePath `
        -ScriptPath $usuario.scriptPath `
        -HomeDrive $usuario.HomeDrive `
        -HomeDirectory $usuario.HomeDirectory `
        -Path $ou `
        -AccountPassword $password `
        -Enabled $true `
        -PasswordNeverExpires $true
}
```

Antes de usarlo en clase hay que adaptar:

- `DC=empresa,DC=local` al dominio real.
- `OU=Usuarios` a la OU real.
- La contraseña inicial.
- Las rutas de perfil y carpeta personal.

## Mini práctica final para la clase

Crear un script llamado `repaso_final.ps1` que:

1. Pida un número al usuario.
2. Muestre su tabla de multiplicar.
3. Indique si es par o impar.
4. Guarde la salida en un fichero `resultado.txt`.

Solución:

```powershell
[int]$numero = Read-Host "Introduce un numero"
$salida = @()

$salida += "Tabla del $numero"

for ($i = 1; $i -le 10; $i++) {
    $salida += "$i x $numero = $($i * $numero)"
}

if ($numero % 2 -eq 0) {
    $salida += "$numero es par"
} else {
    $salida += "$numero es impar"
}

$salida | Out-File -FilePath "./resultado.txt" -Encoding utf8
$salida
```

Ejecución:

```bash
pwsh ./repaso_final.ps1
cat resultado.txt
```

## Preguntas de cierre

1. ¿Qué diferencia hay entre `dir` y `Get-ChildItem`?
2. ¿Qué muestra `Get-Member`?
3. ¿Qué representa `$_` dentro de una tubería?
4. ¿Cuándo usarías `for` y cuándo `foreach`?
5. ¿Por qué es recomendable usar `param` en lugar de depender siempre de `$args`?
