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
if grep -qi Microsoft /proc/version && [[ -f $HOME/.config/Code/User/settings.json ]] && [[ -f $HOME/.vscode/extension.json ]]; then
  echo "Running WSL, symlinking VSCode settings"
  ln -sf $HOME/.config/Code/User/settings.json $HOME/.vscode-server/data/Machine/settings.json
fi

# If running VSCode install extensions
if which code >/dev/null; then
  echo "Installing VSCode extensions"
  cat vscode/extensions.txt | xargs -L 1 code --install-extension
else
  echo "VSCode command does not exist, not installing extensions"
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
