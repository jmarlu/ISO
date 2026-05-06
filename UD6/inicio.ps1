# ================================
# Script de inicio de sesión (ejemplo)
# ================================

# Mostrar mensaje al usuario
Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show("Bienvenido $env:USERNAME`nEste es tu script de inicio.","Inicio de sesión")

# Crear una carpeta personal en el Escritorio si no existe
$carpeta = "$env:USERPROFILE\Desktop\MiCarpeta"
if (!(Test-Path $carpeta)) {
    New-Item -ItemType Directory -Path $carpeta
}

# Crear un archivo de registro con fecha y hora
$log = "$env:USERPROFILE\Desktop\MiCarpeta\login.txt"
Add-Content -Path $log -Value "Inicio de sesión: $(Get-Date)"

# Mapear una unidad de red (ejemplo)
net use Z: \\servidor\recurso /persistent:no

# Mostrar información del equipo
Get-ComputerInfo | Out-File "$env:USERPROFILE\Desktop\MiCarpeta\equipo.txt"
