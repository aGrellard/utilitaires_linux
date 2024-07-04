#!/bin/bash
set -e

echo "Mise à jour des paquets"
sudo apt update

echo "Installation des paquets de base"
sudo apt install -y curl wget git unzip tmux

echo "Installation de zsh"
sudo apt install -y zsh

echo "Téléchargement de oh-my-zsh"
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install_ohmyzsh.sh

echo "Lancer l'installation de oh-my-zsh"
RUNZSH=no sh install_ohmyzsh.sh

echo "Copie du fichier de configuration depuis le dossier parent"
cp ../config/.zshrc ~/.zshrc

echo "Nettoyage du script d'installation"
rm install_ohmyzsh.sh

sudo chsh -s "$(which zsh)" $USER

echo "Installation du plugin zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installation du plugin zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Tout est installé ! Veuillez vous déconnecter et vous reconnecter pour utiliser zsh."

