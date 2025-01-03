#!/bin/bash

# Install Nix
NIX_USE_VERSION=0.32.2
curl --proto '=https' -s -L "https://github.com/DeterminateSystems/nix-installer/releases/download/v$NIX_USE_VERSION/nix-installer.sh" | sh -s -- install --no-confirm

# Install devbox
DEVBOX_USE_VERSION=0.13.7
curl --proto '=https' -s -L https://get.jetify.com/devbox | bash -s -- -f

mkdir -p "$XDG_DATA_HOME/devbox/global/default"
ln -sF "$DOTFILES/configs/devbox/devbox.json" "$XDG_DATA_HOME/devbox/global/default/devbox.json"
ln -sF "$DOTFILES/configs/devbox/devbox.lock" "$XDG_DATA_HOME/devbox/global/default/devbox.lock"

# Install global Devbox packages
devbox global install
