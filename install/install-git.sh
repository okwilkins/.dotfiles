#!/bin/bash

mkdir -p "$XDG_CONFIG_HOME/git"

ln -sf "$DOTFILES/configs/git/config" "$XDG_CONFIG_HOME/git/config"

