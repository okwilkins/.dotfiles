#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/wezterm"
ln -sF "$DOTFILES/configs/wezterm/wezterm.lua" "$XDG_CONFIG_HOME/wezterm/wezterm.lua"

# If in WSL, need to place the Wezterm config here
if [ -n "$WSL_DISTRO_NAME" ]; then
    WIN_HOME_RAW="$(cmd.exe /c "<nul set /p=%UserProfile%" 2>/dev/null)"
    WIN_HOME="$(wslpath $WIN_HOME_RAW)"
    cp "$DOTFILES/configs/wezterm/wezterm.lua" "$WIN_HOME/.wezterm.lua"
fi

