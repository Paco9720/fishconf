#!/usr/bin/env bash
set -e

echo "=== Instalando Zsh y Git ==="

if ! command -v zsh >/dev/null; then
    if command -v dnf >/dev/null; then
        sudo dnf install -y zsh git
    elif command -v apt >/dev/null; then
        sudo apt install -y zsh git
    elif command -v pacman >/dev/null; then
        sudo pacman -S --noconfirm zsh git
    elif command -v zypper >/dev/null; then
        sudo zypper install -y zsh git
    else
        echo "No se detectó gestor de paquetes compatible"
        exit 1
    fi
fi

echo "=== Instalando plugins desde GitHub ==="

PLUGIN_DIR="$HOME/.zsh/plugins"
mkdir -p "$PLUGIN_DIR"

clone() {
    local repo="$1"
    local dir="$2"
    if [ ! -d "$dir" ]; then
        git clone "https://github.com/$repo.git" "$dir"
    else
        echo "✔ $repo ya existe"
    fi
}

clone zsh-users/zsh-autosuggestions "$PLUGIN_DIR/zsh-autosuggestions"
clone zsh-users/zsh-syntax-highlighting "$PLUGIN_DIR/zsh-syntax-highlighting"

echo "=== Creando ~/.zshrc ==="

cat > "$HOME/.zshrc" << 'EOF'
# ===============================
# Zsh portable (sin gestores)
# ===============================

ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"

# -------------------------------
# Completado interactivo (estilo oh-my-zsh)
# -------------------------------
autoload -Uz compinit
compinit

setopt MENU_COMPLETE
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# -------------------------------
# Autosuggestions (automático)
# -------------------------------
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# -------------------------------
# Opciones útiles
# -------------------------------
setopt AUTO_CD
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY

# -------------------------------
# Prompt simple y rápido
# -------------------------------
PROMPT='%F{white}[%~]%f
> '

# -------------------------------
# Syntax highlighting (SIEMPRE al final)
# -------------------------------
source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
EOF

echo "=== Cambiando shell por defecto a zsh ==="
if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi

echo "=== Listo ==="
echo "Cierra sesión y vuelve a entrar"

