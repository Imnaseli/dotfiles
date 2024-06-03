#!/bin/bash

# Define dotfiles directory (source)
DOTFILES_DIR="$HOME/.dotfiles"

# Define target directory for dotfiles
TARGET_DIR="${1:-$HOME}"  # Default to $HOME if no argument is provided

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory '$TARGET_DIR' does not exist."
    exit 1
fi

# Function to create symbolic links if they don't already exist
create_symlink() {
    local source_file=$1
    local target_file=$2
    if [ ! -e "$target_file" ]; then
        ln -sf "$source_file" "$target_file"
        echo "Created symbolic link: $target_file -> $source_file"
    else
        echo "Symbolic link already exists: $target_file"
    fi
}

# Create symbolic links for Neovim configuration
echo "Creating symbolic links for Neovim configuration..."
create_symlink "$DOTFILES_DIR/neovim" "$TARGET_DIR/.config/nvim"

# Create symbolic links for tmux configuration
echo "Creating symbolic links for tmux configuration..."
create_symlink "$DOTFILES_DIR/tmux" "$TARGET_DIR/.tmux"

# Create symbolic links for other dotfiles
echo "Creating symbolic links for other dotfiles..."
create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$TARGET_DIR/.zshrc"
create_symlink "$DOTFILES_DIR/zsh/.bash_aliases" "$TARGET_DIR/.bash_aliases"
create_symlink "$DOTFILES_DIR/ranger" "$TARGET_DIR/.config/ranger"
# Add more symbolic links as needed for other dotfiles

# Install Packer for Neovim if it doesn't already exist
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER_DIR" ]; then
    echo "Installing Packer for Neovim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
    echo "Packer for Neovim installed successfully."
else
    echo "Packer for Neovim already exists."
    echo "Initializing Packer..."
    nvim --headless -c "lua require('packer').startup()" -c "PackerSync" -c "qa"
fi

# Source zshrc to apply changes
echo "Sourcing .zshrc..."
source "$HOME/.zshrc"

echo "Setup completed successfully."

