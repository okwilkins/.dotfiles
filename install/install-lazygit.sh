#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/lazygit"

ln -sf "$DOTFILES/configs/lazygit/config.yaml" "$XDG_CONFIG_HOME/lazygit/config.yml"

