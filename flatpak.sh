#!/bin/bash

set -e

echo "=== Instalando Flatpak en Debian ==="

sudo apt update
sudo apt install flatpak -y

echo "=== Activando Flathub ==="

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "=== Flatpak y Flathub instalados correctamente en Debian ==="

