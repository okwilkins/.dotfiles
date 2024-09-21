#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/wezterm"
ln -sF "$DOTFILES/configs/wezterm/wezterm.lua" "$XDG_CONFIG_HOME/wezterm/wezterm.lua"
