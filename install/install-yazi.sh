#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/yazi"

ln -sf "$DOTFILES/configs/yazi/yazi.toml" "$XDG_CONFIG_HOME/yazi/yazi.toml"
ln -sf "$DOTFILES/configs/yazi/theme.toml" "$XDG_CONFIG_HOME/yazi/theme.toml"
