#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/nvim"
cp -rsv "$DOTFILES/configs/nvim/" "$XDG_CONFIG_HOME/nvim/"
ln -F "$XDG_CONFIG_HOME/nvim/lazy-lock.json" "$DOTFILES/configs/nvim/lazy-lock.json"

