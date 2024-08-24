#!/bin/bash

sudo -v
source ./configs/zsh/.zshenv

echo "Installing Devbox and packages"
. "$DOTFILES/install/install-devbox.sh"

echo "Installing zsh"
. "$DOTFILES/install/install-zsh.sh"

# Make Devboxed zsh the default shell
# Allows root to change shell without a password
sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
command -v $DEVBOX_PACKAGES_DIR/bin/zsh | sudo tee -a /etc/shells

chsh -s $DEVBOX_PACKAGES_DIR/bin/zsh $(whoami)

exec zsh
