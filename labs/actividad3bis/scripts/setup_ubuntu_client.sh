#!/bin/bash
# Script de preparación del Cliente Ubuntu para unirse a Active Directory
# Actividad 3 bis - ISO

set -e

echo "========================================"
echo "Preparando Cliente Ubuntu para AD"
echo "========================================"

# Variables de configuración
DOMAIN_NAME="midominio.local"
DOMAIN_UPPER="MIDOMINIO.LOCAL"
AD_SERVER_IP="192.168.56.10"

# [1/7] Actualizar sistema
echo -e "\n[1/7] Actualizando sistema..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq

# [2/7] Configurar DNS
echo -e "\n[2/7] Configurando DNS para apuntar al servidor AD..."
cat > /etc/netplan/01-netcfg.yaml <<EOF
network:
  version: 2
  ethernets:
    enp0s8:
      addresses:
        - 192.168.56.20/24
      nameservers:
        addresses:
          - ${AD_SERVER_IP}
          - 8.8.8.8
      dhcp4: no
EOF

netplan apply || true

# Configurar resolv.conf
cat > /etc/resolv.conf <<EOF
nameserver ${AD_SERVER_IP}
nameserver 8.8.8.8
search ${DOMAIN_NAME}
EOF

# Hacer resolv.conf inmutable temporalmente
chattr +i /etc/resolv.conf || true

# [3/7] Configurar /etc/hosts
echo -e "\n[3/7] Configurando /etc/hosts..."
cat >> /etc/hosts <<EOF

# Active Directory Domain Controller
${AD_SERVER_IP}    servidorwindows.${DOMAIN_NAME} servidorwindows
192.168.56.20      clienteubuntu.${DOMAIN_NAME} clienteubuntu
EOF

# [4/7] Instalar paquetes necesarios
echo -e "\n[4/7] Instalando paquetes de integración con AD..."
echo "Esto puede tardar varios minutos..."

# Preconfigurar Kerberos para evitar prompts interactivos
echo "krb5-config krb5-config/default_realm string ${DOMAIN_UPPER}" | debconf-set-selections
echo "krb5-config krb5-config/kerberos_servers string servidorwindows.${DOMAIN_NAME}" | debconf-set-selections
echo "krb5-config krb5-config/admin_server string servidorwindows.${DOMAIN_NAME}" | debconf-set-selections

apt-get install -y -qq \
    realmd \
    sssd \
    sssd-tools \
    adcli \
    krb5-user \
    samba-common-bin \
    packagekit \
    libnss-sss \
    libpam-sss \
    oddjob \
    oddjob-mkhomedir

# [5/7] Configurar Kerberos
echo -e "\n[5/7] Configurando Kerberos..."
cat > /etc/krb5.conf <<EOF
[libdefaults]
    default_realm = ${DOMAIN_UPPER}
    dns_lookup_realm = true
    dns_lookup_kdc = true
    ticket_lifetime = 24h
    renew_lifetime = 7d
    forwardable = true
    rdns = false

[realms]
    ${DOMAIN_UPPER} = {
        kdc = servidorwindows.${DOMAIN_NAME}
        admin_server = servidorwindows.${DOMAIN_NAME}
        default_domain = ${DOMAIN_NAME}
    }

[domain_realm]
    .${DOMAIN_NAME} = ${DOMAIN_UPPER}
    ${DOMAIN_NAME} = ${DOMAIN_UPPER}
EOF

# [6/7] Configurar SSSD
echo -e "\n[6/7] Configurando SSSD..."
cat > /etc/sssd/sssd.conf <<EOF
[sssd]
services = nss, pam
config_file_version = 2
domains = ${DOMAIN_NAME}

[domain/${DOMAIN_NAME}]
id_provider = ad
access_provider = ad
auth_provider = ad
chpass_provider = ad
ldap_id_mapping = True
cache_credentials = True
use_fully_qualified_names = False
fallback_homedir = /home/%u
default_shell = /bin/bash

# Configuración de Kerberos
krb5_realm = ${DOMAIN_UPPER}
krb5_server = servidorwindows.${DOMAIN_NAME}

# Configuración de LDAP
ldap_uri = ldap://servidorwindows.${DOMAIN_NAME}
ldap_search_base = dc=midominio,dc=local
ldap_schema = ad
ldap_sasl_mech = GSSAPI
ldap_sasl_authid = CLIENTEUBUNTU$

# Permisos
ad_access_filter = (memberOf=CN=Domain Users,CN=Users,DC=midominio,DC=local)
EOF

chmod 600 /etc/sssd/sssd.conf

# [7/7] Configurar PAM para crear directorios home automáticamente
echo -e "\n[7/7] Configurando PAM para creación automática de directorios home..."
pam-auth-update --enable mkhomedir --force

# Habilitar servicios
systemctl enable sssd
systemctl enable realmd

echo -e "\n========================================"
echo "PREPARACIÓN COMPLETADA"
echo "========================================"
echo "El cliente Ubuntu está listo para unirse al dominio."
echo ""
echo "INFORMACIÓN:"
echo "  - Dominio: ${DOMAIN_NAME}"
echo "  - Servidor AD: ${AD_SERVER_IP}"
echo "  - DNS configurado: ${AD_SERVER_IP}"
echo ""
echo "PRÓXIMOS PASOS MANUALES:"
echo "  1. Espera a que el servidor Windows complete su configuración"
echo "  2. Accede al cliente: vagrant ssh cliente_ubuntu"
echo "  3. Descubre el dominio: realm discover ${DOMAIN_UPPER}"
echo "  4. Únete al dominio: sudo realm join ${DOMAIN_UPPER} -U Administrador"
echo "  5. Verifica: realm list"
echo "  6. Prueba con: id usuario.prueba@${DOMAIN_NAME}"
echo ""
echo "Para dar permisos sudo a Domain Admins:"
echo '  echo "%domain\\ admins ALL=(ALL) ALL" | sudo tee /etc/sudoers.d/domain-admins'
echo "========================================"
