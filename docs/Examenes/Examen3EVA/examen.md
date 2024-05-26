# Examen de la Tercera Evaluación (DIFÍCIL)

## Ejercicio

Crea un script en powershell que haga un backup de una carpeta que se le pase por parámetro . Se hará copia de toda la carpeta, de nuevo de tal manera que sea comprimida.

```PowerShell title="Uso y salida"
.\BackupScript.ps1 -FolderPath"C:\Ruta\De\La\Carpeta"
Backup realizado: C:\Backup\Backup_20240513_124130.zip
```

!!!note

    Comandos que se utilizarán:

        - `New-Object System.IO.FileSystemWatcher` --> Sucripción a diferentes tipos de eventos sobre una carpeta (Changed,create,delete)
        - `Compress-Archive` --> Compresión de la carpeta
        - Ten en cuenta que cada vez que hagas un archivo comprimido el nombre tiene que variar con la fecha (`Get-Date -Format 'yyyyMMdd_HHmmss'`)
        -  $watcher.WaitForChanged($ChangeTypes, $Timeout) Se utiliza para que sincronicamente cuando se produzca un cambio del tipo especificado en la variable $ChangeTypes con $timeout que que es a el tiempo máximo (en milisegundos) que el método esperará a que se produzca un cambio antes de devolver el control.
