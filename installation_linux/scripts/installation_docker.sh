#!/bin/bash

# Arrêter immédiatement le script en cas d'erreur
set -e

# Fonction pour afficher les messages d'erreur
error() {
    echo "Erreur : $1" >&2
    exit 1
}

# Vérification si l'utilisateur est root
if [ "$(id -u)" -ne 0 ]; then
    error "Ce script doit être exécuté avec des privilèges de superutilisateur."
fi


# desisntaller les anciennes versions de docker
echo "Désinstallation des anciennes versions de Docker..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Mise à jour des paquets et installation des dépendances nécessaires pour ajouter un nouveau dépôt
echo "Mise à jour des paquets existants et installation des dépendances nécessaires..."
apt-get update


sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin