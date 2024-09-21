#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/tmux"

ln -sf "$DOTFILES/configs/tmux/tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
ln -sf "$DOTFILES/configs/tmux/tmux.reset.conf" "$XDG_CONFIG_HOME/tmux/tmux.reset.conf"
