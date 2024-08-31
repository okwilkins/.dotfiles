#!/bin/bash

# Install Nix package manager
echo "Installing Nix package manager"
if ! command -v nix &> /dev/null; then
    sh <(curl -sL https://nixos.org/nix/install) --daemon --yes
else
    echo "Nix is already installed! Skipping installation..."
fi

# Install Nix home-manager
echo "Installing Nix home-manager"
if ! command -v home-manager &> /dev/null; then
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
else
    echo "Nix home-manager is already installed! Skipping installation..."
fi

