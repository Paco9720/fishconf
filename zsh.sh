#!/bin/bash

set -e

echo "=== Actualizando repositorios e instalando paquetes necesarios ==="
sudo apt update
sudo apt install -y zsh git curl wget build-essential

echo "=== Instalando Oh My Zsh ==="
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "=== Clonando plugins externos ==="
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting

# zsh-autocompletions
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM}/plugins/zsh-autocomplete

echo "=== Configurando ~/.zshrc ==="

cat > ~/.zshrc << 'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

# Opciones útiles
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY

# Cargar plugins externos
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-autocomplete
EOF

echo "=== Creando ~/.zprofile para iniciar dwm desde TTY1 ==="

cat > ~/.zprofile << 'EOF'
# Iniciar X automáticamente desde TTY1
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
    exec startx
fi
EOF

chmod +x ~/.zprofile

echo "=== Cambiando shell por defecto a zsh ==="
chsh -s /usr/bin/zsh

echo "=== Instalación completa ==="
echo "Cierra sesión y vuelve a entrar en TTY1 para iniciar zsh -> startx -> dwm"

