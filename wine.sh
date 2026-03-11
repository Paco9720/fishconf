#!/bin/bash

# Verificar si el script se ejecuta como root
if [[ $EUID -ne 0 ]]; then
   echo "Por favor, ejecuta este script como root (usando sudo)."
   exit 1
fi

echo "--- Iniciando instalación de WineHQ ---"

# 1. Crear directorio de llaves
mkdir -pm755 /etc/apt/keyrings

# 2. Descargar e instalar la llave de WineHQ
echo "Descargando llave..."
wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key

# 3. Habilitar arquitectura i386
echo "Habilitando arquitectura i386..."
dpkg --add-architecture i386

# 4. Descargar archivo de fuentes
echo "Descargando fuentes para Trixie..."
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources

# 5. Actualizar e instalar
echo "Actualizando repositorios e instalando WineHQ..."
apt update
apt install --install-recommends winehq-stable -y

echo "--- Instalación completada ---"
