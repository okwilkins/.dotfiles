#!/bin/bash

sudo -v
sudo apt update

# Install stow
sudo apt install stow -y

cd configs

for dir in */; do
  echo "Stowing directory: $dir"
  stow -D $dir
  stow $dir -t ~
done

# If running WSL, VSCode needs to be in a seperate location
if [[ $(grep -i Microsoft /proc/version) && $HOME/.config/Code/User/settings.json ]]; then
    echo "Running WSL, symlinking VSCode settings"
    ln -s $HOME/.config/Code/User/settings.json $HOME/.vscode-server/data/Machine/settings.json
fi

cd ..


# Neovim
# NOTE: This won't work on MacOS only only Linux
echo "Installing Neovim"
curl -LO -s https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

# Install ripgrep for telescope
echo "Installing ripgrep"
sudo apt install ripgrep -y


# Zsh setup
echo "Setting up zsh"
# Install zsh
sudo apt install zsh -y

# Make zsh the default shell
chsh -s $(which zsh)

# Zsh plugins
# Install zsh-sytax-highlighting
echo "Installing zsh-syntax-highlighting"
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /opt/zsh-syntax-highlighting

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /opt/zsh-autosuggestions

# Install ohmyzsh
echo "Installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed "2i CHSH=no" | sed "2i KEEP_ZSHRC=yes")"
