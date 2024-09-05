#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/nix"
mkdir -p "$XDG_CONFIG_HOME/nix-linux"

ln -sf "$DOTFILES/configs/nix/nix.conf" "$XDG_CONFIG_HOME/nix/nix.conf"
ln -sf "$DOTFILES/configs/nix-linux/flake.nix" "$XDG_CONFIG_HOME/nix-linux/flake.nix"
ln -sf "$DOTFILES/configs/nix-linux/flake.lock" "$XDG_CONFIG_HOME/nix-linux/flake.lock"
ln -sf "$DOTFILES/configs/nix-linux/home.nix" "$XDG_CONFIG_HOME/nix-linux/home.nix"


cd $XDG_CONFIG_HOME/nix-linux
/nix/var/nix/profiles/default/bin/nix run . -- build --flake .
ln -sf $(readlink result) "$XDG_CONFIG_HOME/nix-config"
rm result
