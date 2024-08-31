#!/bin/bash

# Install Nix package manager
echo "Installing Nix package manager"
sh <(curl -sL https://nixos.org/nix/install) --daemon --yes

# Install Nix home-manager
echo "Installing Nix home-manager"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

