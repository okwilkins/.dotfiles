#!/bin/bash

sudo -v
source ./configs/zsh/zshenv

echo "Installing Devbox and packages"
. "$DOTFILES/install/install-devbox.sh"

echo "Installing zsh"
. "$DOTFILES/install/install-zsh.sh"

echo "Installing nvim"
. "$DOTFILES/install/install-nvim.sh"

# Make Devboxed zsh the default shell
# Allows root to change shell without a password
sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
command -v $DEVBOX_GLOBAL_BIN/zsh | sudo tee -a /etc/shells

chsh -s $DEVBOX_GLOBAL_BIN/zsh $(whoami)

exec $DEVBOX_GLOBAL_BIN/zsh
