#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/nix-linux"

ln -sf "$DOTFILES/configs/nix-linux/nix.conf" "$XDG_CONFIG_HOME/nix-linux/nix.conf"
ln -sf "$DOTFILES/configs/nix-linx/flake.nix" "$XDG_CONFIG_HOME/nix-linux/flake.nix"

