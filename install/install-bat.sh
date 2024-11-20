#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/bat"
mkdir -p "$XDG_CONFIG_HOME/bat/themes"

ln -sf "$DOTFILES/configs/bat/config" "$XDG_CONFIG_HOME/bat/config"
ln -sf "$DOTFILES/configs/bat/themes/catpuccin_mocha.tmTheme" "$XDG_CONFIG_HOME/bat/themes/Catppuccin Mocha.tmTheme"

# Loads the themes
bat cache --build

