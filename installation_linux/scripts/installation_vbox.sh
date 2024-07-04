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
  error "Ce script doit être exécuté avec des privilèges root."
fi

echo "Étape 1: Téléchargement et importation des clés GPG de VirtualBox"
wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg

echo "Étape 2: Ajout du dépôt VirtualBox pour Debian 12"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" | tee /etc/apt/sources.list.d/virtualbox.list

echo "Étape 3: Mise à jour de la liste des paquets disponibles"
apt update

echo "Étape 4: Installation de VirtualBox"
apt install -y virtualbox-7.0

echo "VirtualBox a été installé avec succès."

echo "Étape 5: Installation du pack d'extension VirtualBox (Optionnel)"
VBOX_VERSION=$(vboxmanage -v | cut -dr -f1)
VBOX_EXT_PACK="Oracle_VM_VirtualBox_Extension_Pack-${VBOX_VERSION}.vbox-extpack"
wget "https://download.virtualbox.org/virtualbox/${VBOX_VERSION}/${VBOX_EXT_PACK}"
vboxmanage extpack install "${VBOX_EXT_PACK}" --replace

echo "Le pack d'extension VirtualBox a été installé avec succès."

echo "Étape 6: Ajout de l'utilisateur au groupe vboxusers"
usermod -a -G vboxusers $USER

echo "Script terminé. Veuillez redémarrer votre système pour appliquer les changements."
