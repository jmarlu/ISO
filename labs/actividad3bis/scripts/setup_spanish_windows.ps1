# Script para configurar Windows Server en español
# Actividad 3 bis - ISO

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Configurando idioma español en Windows" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

try {
    # Instalar paquete de idioma español
    Write-Host "`n[1/4] Instalando paquete de idioma español..." -ForegroundColor Yellow
    
    # Configurar español de España como idioma preferido
    $LanguageList = Get-WinUserLanguageList
    $Spanish = New-WinUserLanguageList es-ES
    Set-WinUserLanguageList $Spanish -Force
    
    # Configurar formato regional español
    Write-Host "`n[2/4] Configurando formato regional español..." -ForegroundColor Yellow
    Set-WinHomeLocation -GeoId 217  # España
    Set-Culture es-ES
    Set-WinSystemLocale es-ES
    
    # Configurar zona horaria de España
    Write-Host "`n[3/4] Configurando zona horaria de España..." -ForegroundColor Yellow
    Set-TimeZone -Id "Romance Standard Time"  # Hora de Europa Central (Madrid)
    
    # Configurar teclado español
    Write-Host "`n[4/4] Configurando teclado español..." -ForegroundColor Yellow
    Set-WinDefaultInputMethodOverride -InputTip "0c0a:0000040a"  # Español (España)
    
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "Configuración de español completada" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "`nNOTA: Los cambios se aplicarán completamente después del reinicio" -ForegroundColor Yellow
    
} catch {
    Write-Host "`nError al configurar el idioma: $_" -ForegroundColor Red
    Write-Host "Continuando con la instalación..." -ForegroundColor Yellow
}
