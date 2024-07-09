#!/bin/bash

# Arrêter le script en cas d'erreur
set -e

# Fonction pour afficher les messages d'erreur
error() {
  echo "Erreur: $1" >&2
  exit 1
}

# Vérification si l'utilisateur est root
if [ "$(id -u)" -ne 0 ]; then
  error "Ce script doit être exécuté en tant que root."
fi

echo "Début de l'installation de Visual Studio Code..."

# Mise à jour des paquets
echo "Mise à jour des paquets existants..."
apt-get update || error "La mise à jour des paquets a échoué."

# Installation des dépendances nécessaires
echo "Installation des dépendances nécessaires..."
apt-get install -y wget gpg software-properties-common || error "L'installation des dépendances a échoué."

# Ajout de la clé GPG du dépôt de Microsoft
echo "Ajout de la clé GPG de Microsoft..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

# Ajout du dépôt de VS Code
echo "Ajout du dépôt de Visual Studio Code..."
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

# Nettoyage
rm -f packages.microsoft.gpg

# Mise à jour des paquets après l'ajout du nouveau dépôt
echo "Mise à jour des paquets après l'ajout du dépôt de Visual Studio Code..."
apt-get update || error "La mise à jour des paquets après l'ajout du dépôt a échoué."

# Installation de VS Code
echo "Installation de Visual Studio Code..."
apt-get install -y code || error "L'installation de VS Code a échoué."

echo "Visual Studio Code a été installé avec succès."
