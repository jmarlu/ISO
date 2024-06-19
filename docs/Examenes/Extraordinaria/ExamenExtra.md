# Examen Ordinario.

## Ejercicio 1 (RA5 --> 50%)

Genera un script con el nombre `expore.sh` que:

- Espere **dos argumentos**, el primero de ellos será un directorio y el segundo un fichero. Se debe comprobar que se han pasado exactamente 2 argumentos y que el primero de ellos es
  un directorio y el segundo un fichero.**Condición para corregir el ejercicio.(2pts)**
- El fichero contendrá la siguiente estructura o similar.

      ```bash
          dir alumnos
          fic notas
          dir profesor
          dir equipos
          fic hola
      ```

- Acto seguido el script debe acceder al directorio pasado como primer argumento y recorrer el fichero pasado como segundo argumento. Por cada línea con dir debe crear un directorio
  con el nombre correspondiente, por cada línea con fic debe crear un fichero con el nombre correspondiente. **(4pts)**
- Al finalizar el script debe de indicar el número de ficheros/directorios creados. Por un lado debe indicar los ficheros creados y por otro los directorios, NO LA SUMA DE AMBOS. Por
  ejemplo Ficheros creados: 2 Directorios creados: 2 **(4pts)**

!!! note "Ejercicio shellScript"

    Me tenéis que entregar el fichero explore.sh

## Ejercicio 2 (RA5 --> 30%)

Dado el siguiente script :

```PowerShell title="ScriptCopiaSeguridad"
$FolderPath = "C:\Users\Administrador.WIN-OT4FJF7Q1AT\temp"

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

### Ejercicio 1 (60%)

Analiza y describe **con vuestras palabras (no copiar y pegar) y pormenorizadamnete**, es decir todas sus instrucciones y concluye con la utilidad del mismo. Para ello tendrás la ayuda que nos proporciona windows tanto online como offline.

### Ejercicio 2 (40%)

Modifica el mismo para que sea obligatorio la introducción como parámetro del directorio en cuestión es decir:

```PowerShell title=""
.\script -dir "c:\user"

```

!!! note "Ejercicio Powershell"

    Me tenéis que entregar dos ficheros el primero con las explicaciones en formato pdf y el segundo .ps1.

!!! note "Porcentaje de las notas"

    Para este RA los porcentajes son las siguietentes:
    - Ejercicio 1 examen 50%
    - Ejercicio 2 examen 30%
    - Actividades 20%
