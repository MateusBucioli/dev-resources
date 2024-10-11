url=$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9\.]+linux-amd64.tar.gz' | head -n 1); wget https://dl.google.com/go/$url -O /tmp/golang.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/golang.tar.gz
sudo rm /tmp/golang.tar.gz

fish_config="$HOME/.config/fish/config.fish"
if [ -f "$fish_config" ]; then
    if ! grep -q "set -gx PATH /usr/local/go/bin \$PATH" $fish_config; then
        echo "Adding Go to PATH in $fish_config..."
        echo "" >> $fish_config
        echo "# Add Go to PATH" >> $fish_config
        echo "set -gx PATH /usr/local/go/bin \$PATH" >> $fish_config && echo "Path added successfully in $fish_config"
        echo "Run 'source $fish_config' to apply changes"
    else
        echo "Go path already configured in $fish_config"
    fi
else
    zsh_config="$HOME/.zshrc"
    if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" $zsh_config; then
        echo "Adding Go to PATH in $zsh_config..."
        echo "" >> $fish_config
        echo "# Add Go to PATH" >> $zsh_config
        echo "export PATH=\$PATH:/usr/local/go/bin" >> $zsh_config
        echo "Run 'source $zsh_config' to apply changes"
    else
    echo "Go path already configured in $zsh_config"
    fi
fi

echo ""
echo "Go installed successfully"
