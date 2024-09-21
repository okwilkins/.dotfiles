#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/k9s"

ln -sf "$DOTFILES/configs/k9s/config.yaml" "$XDG_CONFIG_HOME/k9s/config.yaml"

# Skins
ln -sf "$DOTFILES/configs/k9s/skins/catppuccin-mocha.yaml" "$XDG_CONFIG_HOME/k9s/skins/catppuccin-mocha.yaml"
ln -sf "$DOTFILES/configs/k9s/skins/catppuccin-mocha-transparent.yaml" "$XDG_CONFIG_HOME/k9s/skins/catppuccin-mocha-transparent.yaml"
