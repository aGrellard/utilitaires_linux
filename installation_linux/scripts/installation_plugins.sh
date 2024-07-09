echo "Sauvegarde du fichier de configuration zsh existant"
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak

echo "Installation du plugin zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installation du plugin zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Mise à jour du fichier de configuration zsh"
wget -O /tmp/.zshrc https://raw.githubusercontent.com/aGrellard/documentations_linux/main/_A0_BACKUP_LINUX/debian12/shell/.zshrc
cp /tmp/.zshrc ~/.zshrc

echo "Tout est installé ! Veuillez vous déconnecter et vous reconnecter pour utiliser zsh."
