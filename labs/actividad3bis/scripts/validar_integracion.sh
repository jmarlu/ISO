#!/bin/bash
# Script de validación para verificar que el cliente Ubuntu
# está correctamente integrado con Active Directory

echo "=========================================="
echo "VALIDACIÓN DE INTEGRACIÓN CON AD"
echo "=========================================="

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para verificar
check() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC}"
        return 0
    else
        echo -e "${RED}✗ FAIL${NC}"
        return 1
    fi
}

# Variables
DOMAIN="midominio.local"
DOMAIN_UPPER="MIDOMINIO.LOCAL"
AD_SERVER="192.168.56.10"
TEST_USER="usuario.prueba"

echo ""
echo "1. Verificando conectividad con el servidor AD..."
ping -c 2 $AD_SERVER > /dev/null 2>&1
check

echo ""
echo "2. Verificando resolución DNS del dominio..."
nslookup $DOMAIN > /dev/null 2>&1
check

echo ""
echo "3. Verificando que SSSD está corriendo..."
systemctl is-active --quiet sssd
check

echo ""
echo "4. Verificando descubrimiento del dominio..."
realm discover $DOMAIN_UPPER > /dev/null 2>&1
check

echo ""
echo "5. Verificando que el cliente está unido al dominio..."
realm list | grep -q "configured: kerberos-member"
check

echo ""
echo "6. Verificando que se puede obtener información del usuario de prueba..."
id $TEST_USER > /dev/null 2>&1
if check; then
    echo "   Usuario: $(id $TEST_USER)"
fi

echo ""
echo "7. Verificando que NSS puede resolver usuarios del dominio..."
getent passwd $TEST_USER > /dev/null 2>&1
if check; then
    echo "   $(getent passwd $TEST_USER)"
fi

echo ""
echo "8. Verificando configuración de Kerberos..."
if [ -f /etc/krb5.conf ]; then
    grep -q "$DOMAIN_UPPER" /etc/krb5.conf
    check
else
    echo -e "${RED}✗ FAIL - /etc/krb5.conf no existe${NC}"
fi

echo ""
echo "9. Verificando configuración de SSSD..."
if [ -f /etc/sssd/sssd.conf ]; then
    sudo grep -q "$DOMAIN" /etc/sssd/sssd.conf
    check
else
    echo -e "${RED}✗ FAIL - /etc/sssd/sssd.conf no existe${NC}"
fi

echo ""
echo "10. Verificando que pam_mkhomedir está habilitado..."
grep -q "pam_mkhomedir" /etc/pam.d/common-session
check

echo ""
echo "=========================================="
echo "RESUMEN DE VALIDACIÓN"
echo "=========================================="

# Verificación final
if realm list | grep -q "configured: kerberos-member"; then
    echo -e "${GREEN}✓ El cliente está correctamente unido al dominio${NC}"
    echo ""
    echo "Información del dominio:"
    realm list
    echo ""
    echo -e "${YELLOW}Próximos pasos:${NC}"
    echo "  1. Probar inicio de sesión: ssh $TEST_USER@localhost"
    echo "  2. Verificar ticket Kerberos: kinit $TEST_USER@$DOMAIN_UPPER && klist"
    echo "  3. Verificar sudo (si está en Domain Admins): sudo whoami"
else
    echo -e "${RED}✗ El cliente NO está unido al dominio${NC}"
    echo ""
    echo -e "${YELLOW}Para unirse al dominio:${NC}"
    echo "  sudo realm join $DOMAIN_UPPER -U Administrador"
fi

echo "=========================================="
