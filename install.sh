#!/bin/bash

sudo -v
source ./configs/zsh/zshenv

echo "Installing Devbox and packages"
. "$DOTFILES/install/install-devbox.sh"

echo "Installing zsh"
. "$DOTFILES/install/install-zsh.sh"

echo "Installing Git"
. "$DOTFILES/install/install-git.sh"

echo "Installing nvim"
. "$DOTFILES/install/install-nvim.sh"

echo "Installing Wezterm"
. "$DOTFILES/install/install-wezterm.sh"

echo "Installing Tmux"
. "$DOTFILES/install/install-tmux.sh"

echo "Installing K9s"
. "$DOTFILES/install/install-k9s.sh"

echo "Installing Lazygit"
. "$DOTFILES/install/install-lazygit.sh"

echo "Installing Bat"
. "$DOTFILES/install/install-bat.sh"

echo "Installing Yazi"
. "$DOTFILES/install/install-yazi.sh"

echo "Installing Rainfrog"
. "$DOTFILES/install/install-rainfrog.sh"

# Make Devboxed zsh the default shell
# Allows root to change shell without a password
sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
command -v $DEVBOX_GLOBAL_BIN/zsh | sudo tee -a /etc/shells

chsh -s $DEVBOX_GLOBAL_BIN/zsh $(whoami)

exec $DEVBOX_GLOBAL_BIN/zsh
