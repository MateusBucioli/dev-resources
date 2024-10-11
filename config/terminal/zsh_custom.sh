#   Install FiraCode
wget -x https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip -O /tmp/FiraCode.zip
sudo apt install unzip -y
sudo unzip /tmp/FiraCode.zip -d /usr/share/fonts/ && sudo rm /tmp/FiraCode.zip

# Install ZSH, suggestions, autocomplete and configure some plugins
sudo apt install zsh -y
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -r '/plugins=\(/ s/(^.*)(=.*)/\1=\(git golang docker docker-compose zsh-autosuggestions zsh-syntax-highlighting\)/g' -i ~/.zshrc

# Install P10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
