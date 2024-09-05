#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/nix"
mkdir -p "$XDG_CONFIG_HOME/nix-linux"

ln -sf "$DOTFILES/configs/nix/nix.conf" "$XDG_CONFIG_HOME/nix/nix.conf"
ln -sf "$DOTFILES/configs/nix-linux/flake.nix" "$XDG_CONFIG_HOME/nix-linux/flake.nix"
ln -sf "$DOTFILES/configs/nix-linux/flake.lock" "$XDG_CONFIG_HOME/nix-linux/flake.lock"
ln -sf "$DOTFILES/configs/nix-linux/home.nix" "$XDG_CONFIG_HOME/nix-linux/home.nix"


cd $DOTFILES/configs/nix-linux
nix run . -- build --flake .
ln -sf "$XDG_CONFIG_HOME/nix-config" $(readlink result)
rm result
