#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -x  # Print commands and their arguments as they are executed

# Update package lists
sudo apt update

# Install required packages
echo "Installing build prerequisites..."
sudo apt install -y git build-essential cmake

# Clone Neovim repository
echo "Cloning Neovim repository..."
git clone https://github.com/neovim/neovim

# Navigate into the Neovim directory
cd neovim

# Optionally, switch to stable release
echo "Switching to stable release..."
git checkout stable

# Build Neovim with RelWithDebInfo build type
echo "Building Neovim..."
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Install Neovim
echo "Installing Neovim..."
sudo make install

# Clean up
echo "Cleaning up..."
cd ..
rm -rf neovim

# Add Neovim binary directory to PATH
echo "Adding Neovim binary directory to PATH..."
echo 'export PATH="$PATH:/usr/local/bin"' >> "$HOME/.zshrc"

# Confirm shell change
echo "Current shell:"
echo $SHELL

echo "Pre-installation script completed successfully."

