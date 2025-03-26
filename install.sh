#!/bin/bash

set -euo pipefail

PACKAGES=(
    i3-wm i3status i3lock dmenu feh picom rofi tmux ranger neovim alacritty
    zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions
)

CONFIG_DIRS=(
    i3 i3status picom rofi ranger alacritty nvim
)

function install_packages() {
    echo "Atualizando o sistema..."
    sudo pacman -Syu --noconfirm

    echo "Instalando pacotes necessários..."
    for package in "${PACKAGES[@]}"; do
        if ! pacman -Q "$package" &>/dev/null; then
            sudo pacman -S --noconfirm "$package"
        else
            echo "[INFO] Pacote $package já está instalado, pulando..."
        fi
    done
}

function create_directories() {
    echo "Criando diretórios de configuração..."
    mkdir -p ~/.config ~/pictures/wallpapers ~/.fonts

    for dir in "${CONFIG_DIRS[@]}"; do
        mkdir -p "$HOME/.config/$dir"
    done
}

function copy_config_files() {
    echo "Copiando arquivos de configuração..."

    for dir in "${CONFIG_DIRS[@]}"; do
        if [ -d "config/$dir" ]; then
            cp -r "config/$dir/"* "$HOME/.config/$dir/"
        else
            echo "[WARNING] Diretório config/$dir não encontrado. Pulando..."
        fi
    done

    [[ -f config/tmux/.tmux.conf ]] && cp config/tmux/.tmux.conf ~/.tmux.conf || echo "[WARNING] Arquivo .tmux.conf não encontrado"

    [[ -d wallpapers ]] && cp -r wallpapers/* ~/pictures/wallpapers/ || echo "[WARNING] Diretório wallpapers não encontrado"
    
    [[ -d fonts ]] && cp -r fonts/* ~/.fonts/ || echo "[WARNING] Diretório fonts não encontrado"
}

function configure_permissions() {
    echo "Definindo permissões..."
    [[ -f ~/.config/i3/autostart.sh ]] && chmod +x ~/.config/i3/autostart.sh
}

function set_default_wm() {
    echo "Configurando o i3 como WM padrão..."
    echo "exec i3" > ~/.xinitrc
}

function install_oh_my_zsh() {
    echo "Instalando Oh My Zsh..."
    
    if ! command -v zsh &>/dev/null; then
        echo "[ERROR] O Zsh não foi encontrado. Algo deu errado na instalação dos pacotes."
        exit 1
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Baixando e instalando Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "[INFO] Oh My Zsh já instalado, pulando..."
    fi

    echo "Definindo Zsh como shell padrão..."
    chsh -s "$(which zsh)"

    echo "Configurando Zsh..."
    [[ -f config/zsh/.zshrc ]] && cp config/zsh/.zshrc ~/.zshrc || echo "[WARNING] Arquivo .zshrc não encontrado"
}

function main() {
    install_packages
    create_directories
    copy_config_files
    configure_permissions
    set_default_wm
    install_oh_my_zsh

    echo "Instalação concluída! Reinicie a sessão para aplicar as configurações."
}

main
