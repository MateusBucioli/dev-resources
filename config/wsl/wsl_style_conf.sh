#!/bin/bash

# Prompt user to choose what shell to use
printf "\nChoose your preferred shell:\n"
printf "1. Install fish shell\n"
printf "2. Install zsh shell\n"
read -p "Enter your choice (1 or 2): " choice

# Validate user input:
if [ $choice -ne 1 -a $choice -ne 2 ]; then
  echo "Invalid choice. Please enter 1 or 2."
  exit 1
fi

if [ $choice -eq 1 ]; then
  if [ ! -f /usr/bin/fish ]; then
    sudo apt install fish -y
    chsh -s /usr/bin/fish || chsh -s /bin/fish
  elif
    echo "fish is already installed."
    exit 1
  fi
fi

if [ $choice -eq 2 ]; then
  if [ ! -f /usr/bin/zsh ]; then
    sudo apt install zsh -y
    chsh -s /usr/bin/zsh || chsh -s /bin/zsh
  elif
    echo "zsh is already installed."
    exit 1
  fi
fi

# Inform the user about completion:
printf "\n%s installation complete.\n" "$((choice == 1 ? "fish" : "zsh"))"
exit 0
