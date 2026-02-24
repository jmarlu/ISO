#!/bin/bash
# ================================
# Script de inicio de sesión (ejemplo)
# ================================

echo "Bienvenido/a $USER. Fecha: $(date)" | wall 2>/dev/null

# 1) Crear carpeta en el HOME si no existe
CARPETA="$HOME/mi_carpeta"
mkdir -p "$CARPETA"

# 2) Guardar un registro del inicio de sesión
echo "Inicio de sesión de $USER en $(hostname) a las $(date)" >> "$CARPETA/login.txt"

# 3) Mostrar info básica del sistema en un fichero
{
  echo "Usuario: $USER"
  echo "Equipo: $(hostname)"
  echo "Fecha: $(date)"
  echo "Kernel: $(uname -r)"
} > "$CARPETA/info_equipo.txt"

# 4) (Ejemplo) Mensaje por pantalla
echo "Script de inicio ejecutado. Revisa: $CARPETA/"
