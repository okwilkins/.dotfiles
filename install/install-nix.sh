#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/nix"

ln -sf "$DOTFILES/configs/nix/nix.conf" "$XDG_CONFIG_HOME/nix/nix.conf"
