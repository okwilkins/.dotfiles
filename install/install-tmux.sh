#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/tmux"

ln -sf "$DOTFILES/configs/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
ln -sf "$DOTFILES/configs/tmux/tmux.keybinds.conf" "$XDG_CONFIG_HOME/tmux/tmux.keybinds.conf"
