#!/bin/bash
# Script para instalar entorno gráfico y configurar español en Ubuntu
# Actividad 3 bis - ISO

set -e

echo "=========================================="
echo "Instalando entorno gráfico y español"
echo "=========================================="

export DEBIAN_FRONTEND=noninteractive

# [1/6] Configurar locales español
echo -e "\n[1/6] Configurando locales en español..."
apt-get update -qq

# Instalar locales
apt-get install -y -qq locales

# Generar locales español
locale-gen es_ES.UTF-8
update-locale LANG=es_ES.UTF-8 LANGUAGE=es_ES:es LC_ALL=es_ES.UTF-8

# Configurar locale por defecto
cat > /etc/default/locale <<EOF
LANG=es_ES.UTF-8
LANGUAGE=es_ES:es
LC_ALL=es_ES.UTF-8
EOF

# [2/6] Configurar zona horaria
echo -e "\n[2/6] Configurando zona horaria de España..."
timedatectl set-timezone Europe/Madrid

# [3/6] Configurar teclado español
echo -e "\n[3/6] Configurando teclado español..."
cat > /etc/default/keyboard <<EOF
XKBMODEL="pc105"
XKBLAYOUT="es"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF

# [4/6] Instalar entorno gráfico GNOME
echo -e "\n[4/6] Instalando entorno gráfico GNOME..."
echo "Esto puede tardar varios minutos (5-10 min)..."

# Instalar GNOME Desktop Environment
apt-get install -y -qq \
    ubuntu-desktop \
    gnome-shell \
    gnome-terminal \
    gnome-control-center \
    gnome-tweaks \
    language-pack-es \
    language-pack-gnome-es

# [5/6] Configurar GDM (GNOME Display Manager)
echo -e "\n[5/6] Configurando gestor de inicio de sesión..."

# Habilitar inicio automático de GDM
systemctl set-default graphical.target
systemctl enable gdm

# Configurar GDM en español
cat > /etc/gdm3/custom.conf <<EOF
# GDM configuration storage

[daemon]
# Uncomment the line below to force the login screen to use Xorg
#WaylandEnable=false

[security]

[xdmcp]

[chooser]

[debug]
# Uncomment the line below to turn on debugging
#Enable=true
EOF

# [6/6] Configurar idioma del sistema
echo -e "\n[6/6] Configurando idioma del sistema..."

# Actualizar configuración de idioma
update-locale LANG=es_ES.UTF-8

# Configurar variables de entorno para todos los usuarios
cat >> /etc/environment <<EOF

# Configuración de idioma español
LANG=es_ES.UTF-8
LANGUAGE=es_ES:es
LC_ALL=es_ES.UTF-8
EOF

# Configurar español como idioma predeterminado para nuevos usuarios
cat > /etc/profile.d/spanish-locale.sh <<'EOF'
export LANG=es_ES.UTF-8
export LANGUAGE=es_ES:es
export LC_ALL=es_ES.UTF-8
EOF

chmod +x /etc/profile.d/spanish-locale.sh

echo -e "\n=========================================="
echo "INSTALACIÓN COMPLETADA"
echo "=========================================="
echo "Entorno gráfico: GNOME Desktop"
echo "Idioma: Español (España)"
echo "Zona horaria: Europe/Madrid"
echo "Teclado: Español"
echo ""
echo "NOTA: El entorno gráfico estará disponible después del reinicio"
echo "      Para reiniciar: vagrant reload cliente_ubuntu"
echo "=========================================="

# Crear archivo de información
cat > /home/vagrant/LEEME.txt <<EOF
========================================
INFORMACIÓN DEL SISTEMA
========================================

Entorno gráfico: GNOME Desktop instalado
Idioma: Español (España)
Zona horaria: Europe/Madrid
Teclado: Español

Para iniciar sesión en el entorno gráfico:
- Usuario: vagrant
- Contraseña: vagrant

Para cambiar entre terminal y GUI:
- Ctrl + Alt + F1 a F6: Terminales virtuales
- Ctrl + Alt + F7: Entorno gráfico

Comandos útiles:
- Verificar idioma: locale
- Verificar zona horaria: timedatectl
- Reiniciar entorno gráfico: sudo systemctl restart gdm

========================================
EOF

chown vagrant:vagrant /home/vagrant/LEEME.txt
