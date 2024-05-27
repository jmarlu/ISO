# Examen de la Tercera Evaluación

## Ejercicio

Dado el siguiente script :

```PowerShell title="ScriptCopiaSeguridad"

        $ChangeTypes = [System.IO.WatcherChangeTypes]::Created, [System.IO.WatcherChangeTypes]::Deleted, [System.IO.WatcherChangeTypes]::Changed,[System.IO.WatcherChangeTypes]::Renamed
Write-Host $FolderPath
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $FolderPath
$watcher.Filter='\*'
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true
$watcher.NotifyFilter=$ChangeTypes
$Timeout=1000

function Backup-Folder {
    $backupFolder = "C:\Backup"  # Carpeta donde se almacenarán los respaldos

    # Crear la carpeta de respaldo si no existe
    if (-not (Test-Path -Path $backupFolder)) {
        New-Item -ItemType Directory -Path $backupFolder
    }º

    # Nombre del archivo de respaldo
    $backupFileName = "Backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').zip"
    $backupFilePath = Join-Path -Path $backupFolder -ChildPath $backupFileName

    # Crear el archivo de respaldo
    Compress-Archive -Path $FolderPath -DestinationPath $backupFilePath -Force

    Write-Output "Backup realizado: $backupFilePath"
}

do {

    $result = $watcher.WaitForChanged($ChangeTypes, $Timeout)
     if ($result.TimedOut) { continue }
     Backup-Folder

} while ($true)

```

## Ejercicio 1

Analiza y describe **con vuestras palabras (no copiar y pegar) y pormenorizadamnete**, es decir todas sus instrucciones y concluye con la utilidad del mismo. Para ello tendrás la ayuda que nos proporciona windows tanto online como offline.

## Ejercicio 2

Modifica el mismo para que sea obligatorio la introducción como parámetro del directorio en cuestión es decir:

```PowerShell title=""
.\script -dir "c:\user"

```

!!! note

    Me tenéis que entregar dos ficheros el primero con las explicaciones en formato pdf y el segundo .ps1.
