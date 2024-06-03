#!/bin/bash

# Update package lists
sudo apt update

# Install required packages
echo "Installing tmux, zsh, and ranger..."
sudo apt install -y tmux zsh ranger fzf ninja-build gettext cmake unzip curl build-essential

echo "gh cli for login"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

# Download and install Neovim pre-built binaries
chmod +x install_neovim.sh
./install_neovim.sh

# Add Neovim binary directory to PATH
echo "Adding Neovim binary directory to PATH..."
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> "$HOME/.zshrc"

# Change default shell to zsh
echo "Changing default shell to zsh..."
sudo chsh -s $(which zsh)

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing zsh-autosuggestions and zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Confirm shell change
echo "Current shell:"
echo $SHELL

echo "Pre-installation script completed successfully."

