#!/bin/bash

sudo -v
sudo apt update

# Install stow
sudo apt install stow -y

# Stow directories
if [[ -z $STOW_DIRS ]]; then
  STOW_DIRS=".config,zsh"
fi

for dir in $(echo $STOW_DIRS | sed "s/,/ /g")
do
  echo "Stowing directory: $dir"
  stow -D $dir
  stow $dir
done


# Neovim
# NOTE: This won't work on MacOS only only Linux
curl -LO -s https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz


# Zsh setup
# Install zsh
sudo apt install zsh -y

# Make zsh the default shell
chsh -s $(which zsh)

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

