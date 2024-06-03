#!/bin/bash

# Update package lists
sudo apt update

# Install required packages
echo "Installing tmux, neovim, zsh, and ranger..."
sudo apt install -y tmux neovim zsh ranger

echo "gh cli for login"
snap install gh

# Download and install Neovim pre-built binaries
echo "Downloading and installing Neovim pre-built binaries..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# Add Neovim binary directory to PATH
echo "Adding Neovim binary directory to PATH..."
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> "$HOME/.zshrc"

# Change default shell to zsh
echo "Changing default shell to zsh..."
sudo chsh -s $(which zsh)

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Confirm shell change
echo "Current shell:"
echo $SHELL

echo "Pre-installation script completed successfully."

