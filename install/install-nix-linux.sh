#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/nix"
mkdir -p "$XDG_CONFIG_HOME/home-manager"

ln -sf "$DOTFILES/configs/nix/nix.conf" "$XDG_CONFIG_HOME/nix/nix.conf"
ln -sf "$DOTFILES/configs/home-manager/flake.nix" "$XDG_CONFIG_HOME/home-manager/flake.nix"
ln -sf "$DOTFILES/configs/home-manager/flake.lock" "$XDG_CONFIG_HOME/home-manager/flake.lock"
ln -sf "$DOTFILES/configs/home-manager/home.nix" "$XDG_CONFIG_HOME/home-manager/home.nix"

