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
if grep -qi Microsoft /proc/version && [[ -f $HOME/.config/Code/User/settings.json ]]; then
  echo "Running WSL, symlinking VSCode settings"
  ln -sf $HOME/.config/Code/User/settings.json $HOME/.vscode-server/data/Machine/settings.json
fi

# If running VSCode install extensions
if which code >/dev/null; then
  echo "Installing VSCode extensions"
  cat vscode/.config/Code/extentions.txt | xargs -L 1 code --install-extension
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
sudo chsh -s $(which zsh)

# Install ohmyzsh
echo "Installing ohmyzsh"
rm -rf $HOME/.oh-my-zsh 
curl -s https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o oh-my-zsh-install.sh&&
sed -i "2i CHSH=no" oh-my-zsh-install.sh
sed -i "2i KEEP_ZSHRC=yes" oh-my-zsh-install.sh
chmod +x oh-my-zsh-install.sh
./oh-my-zsh-install.sh &
wait
rm oh-my-zsh-install.sh

# Zsh plugins
echo "Installing zsh-syntax-highlighting"
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh-autosuggestions"
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
