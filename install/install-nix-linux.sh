#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/nix"
mkdir -p "$XDG_CONFIG_HOME/nix-linux"

ln -sf "$DOTFILES/configs/nix/nix.conf" "$XDG_CONFIG_HOME/nix/nix.conf"
ln -sf "$DOTFILES/configs/nix-linux/flake.nix" "$XDG_CONFIG_HOME/nix-linux/flake.nix"
ln -sf "$DOTFILES/configs/nix-linux/flake.lock" "$XDG_CONFIG_HOME/nix-linux/flake.lock"


# Install Nix home-manager
echo "Installing Nix home-manager"
if ! command -v home-manager &> /dev/null; then
    /nix/var/nix/profiles/default/bin/nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    /nix/var/nix/profiles/default/bin/nix-channel --update
    /nix/var/nix/profiles/default/bin/nix-shell '<home-manager>' -A install
else
    echo "Nix home-manager is already installed! Skipping installation..."
fi

