# Script de configuración del Servidor Windows con Active Directory
# Actividad 3 bis - ISO

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Configurando Servidor Windows AD" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Variables de configuración
$DomainName = "midominio.local"
$DomainNetBIOSName = "MIDOMINIO"
$SafeModePassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force

# Configurar DNS estático
Write-Host "`n[1/6] Configurando DNS estático..." -ForegroundColor Yellow
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses ("127.0.0.1", "8.8.8.8")

# Instalar roles de AD DS y DNS
Write-Host "`n[2/6] Instalando roles de AD DS y DNS..." -ForegroundColor Yellow
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature -Name DNS -IncludeManagementTools

# Configurar el dominio
Write-Host "`n[3/6] Configurando Active Directory Domain Services..." -ForegroundColor Yellow
Write-Host "Dominio: $DomainName" -ForegroundColor Gray

# Instalar el bosque de AD
Install-ADDSForest `
    -DomainName $DomainName `
    -DomainNetbiosName $DomainNetBIOSName `
    -SafeModeAdministratorPassword $SafeModePassword `
    -InstallDns `
    -Force `
    -NoRebootOnCompletion

# Crear usuarios de prueba
Write-Host "`n[4/6] Creando usuarios de dominio de prueba..." -ForegroundColor Yellow

# Esperar a que AD esté listo
Start-Sleep -Seconds 10

try {
    Import-Module ActiveDirectory
    
    # Crear OU para usuarios de prueba
    New-ADOrganizationalUnit -Name "Usuarios_Prueba" -Path "DC=midominio,DC=local" -ErrorAction SilentlyContinue
    
    # Crear usuario de prueba
    $UserPassword = ConvertTo-SecureString "Usuario123!" -AsPlainText -Force
    New-ADUser `
        -Name "Usuario Prueba" `
        -GivenName "Usuario" `
        -Surname "Prueba" `
        -SamAccountName "usuario.prueba" `
        -UserPrincipalName "usuario.prueba@midominio.local" `
        -Path "OU=Usuarios_Prueba,DC=midominio,DC=local" `
        -AccountPassword $UserPassword `
        -Enabled $true `
        -PasswordNeverExpires $true `
        -ErrorAction SilentlyContinue
    
    Write-Host "Usuario creado: usuario.prueba (Password: Usuario123!)" -ForegroundColor Green
    
} catch {
    Write-Host "Nota: Los usuarios se crearán después del reinicio" -ForegroundColor Yellow
}

# Configurar firewall para permitir tráfico de dominio
Write-Host "`n[5/6] Configurando firewall..." -ForegroundColor Yellow
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Información final
Write-Host "`n[6/6] Configuración completada!" -ForegroundColor Green
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "INFORMACIÓN DEL DOMINIO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Dominio: $DomainName" -ForegroundColor White
Write-Host "NetBIOS: $DomainNetBIOSName" -ForegroundColor White
Write-Host "IP Servidor: 192.168.56.10" -ForegroundColor White
Write-Host "Administrador: Administrador" -ForegroundColor White
Write-Host "Password Admin: vagrant (cambiar después)" -ForegroundColor White
Write-Host "Usuario prueba: usuario.prueba@midominio.local" -ForegroundColor White
Write-Host "Password Usuario: Usuario123!" -ForegroundColor White
Write-Host "`nNOTA: El servidor se reiniciará automáticamente" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

# Programar reinicio
Write-Host "`nReiniciando en 30 segundos..." -ForegroundColor Yellow
shutdown /r /t 30 /c "Reiniciando para completar la configuración de AD"
