#!/bin/bash

set -e

echo "Atualizando o sistema..."
sudo pacman -Syu --noconfirm

echo "Instalando pacotes necessários..."
sudo pacman -S --noconfirm i3-wm i3status i3lock dmenu feh picom rofi tmux ranger nvim alacritty

echo "Criando diretórios de configuração..."
mkdir -p ~/.config/{i3,i3status,picom,rofi,ranger,alacritty,nvim} ~/pictures/wallpapers ~/.fonts

echo "Copiando arquivos de configuração..."
cp -r config/i3/* ~/.config/i3/
cp -r config/i3status/* ~/.config/i3status/
cp -r config/picom/* ~/.config/picom/
cp -r config/rofi/* ~/.config/rofi/
cp -r config/ranger/* ~/.config/ranger/
cp -r config/alacritty/* ~/.config/alacritty/
cp -r config/nvim/* ~/.config/nvim/
cp -r config/tmux/.tmux.conf ~/.tmux.conf
cp wallpapers/* ~/pictures/wallpapers/
cp fonts/* ~/.fonts/

echo "Definindo permissões..."
chmod +x ~/.config/i3/autostart.sh

echo "Configurando o i3 como WM padrão..."
echo "exec i3" > ~/.xinitrc

echo "Instalando Zsh e Oh My Zsh..."
sudo pacman -S --noconfirm zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Baixando e instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Definindo Zsh como shell padrão..."
chsh -s $(which zsh)

echo "Configurando Zsh..."
cp config/zsh/.zshrc ~/.zshrc


echo "Instalação concluída! Reinicie a sessão para aplicar as configurações."

