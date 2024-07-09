#!/bin/bash
set -e

# Vérifie si au moins un paramètre a été saisi
if [ $# -eq 0 ]; then
    echo "Erreur : Aucun paramètre saisi."
    echo "Usage : $0 <paramètre>"
    exit 1
fi


# met à jour la liste des paquets et installe le paquet 'sudo'.
echo "Mise a jour de la liste des paquest et installation du paquet sudo"
apt update && apt install sudo -y

echo "Ajout de l'utilisateur $1 au groupe sudo"
# Ajoute l'utilisateur spécifié au groupe sudo
usermod -aG sudo $1