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

echo "Installation terminée avec succès !"
echo "Veuillez redémarrer votre terminal ou exécuter 'zsh' pour commencer à utiliser oh-my-zsh."
