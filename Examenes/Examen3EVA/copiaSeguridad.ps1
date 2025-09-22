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
