#!/bin/bash

sudo apt update

# Install stow
sudo apt install stow


# Zsh setup
# Install zsh
sudo apt install zsh

# Make zsh the default shell
chsh -s $(which zsh)

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Neovim
# NOTE: This won't work on MacOS only only Linux
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

