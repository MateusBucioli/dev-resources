rm -f ~/.p10k.zsh
rm -rf -- ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sh ~/.oh-my-zsh/tools/uninstall.sh -y
sudo chsh -s $(which bash)
sudo apt remove zsh -y && sudo apt autoremove -y
rm -Rf ~/.zsh*
