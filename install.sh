#!/bin/bash

sudo -v
source ./configs/zsh/zshenv


# Install Nix package manager
echo "Installing Nix package manager"
if ! command -v nix &> /dev/null; then
    sh <(curl -sL https://nixos.org/nix/install) --daemon --yes
else
    echo "Nix is already installed! Skipping installation..."
fi


# Installs
for file in ./install/*.sh; do
    echo "Running: $file"
    # Run each script in a new bash subshell with Nix environment
    # When Nix is newly installed you need to restart the shell to gain access to the command
    bash -c "source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && bash $file"
done


# Make zsh the default shell
# Allows root to change shell without a password
# sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
# command -v $DEVBOX_GLOBAL_BIN/zsh | sudo tee -a /etc/shells

# chsh -s $DEVBOX_GLOBAL_BIN/zsh $(whoami)

# exec $DEVBOX_GLOBAL_BIN/zsh
