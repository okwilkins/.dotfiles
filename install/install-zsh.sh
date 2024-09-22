#!/bin/bash

mkdir -p "$ZDOTDIR"

ln -sf "$DOTFILES/configs/zsh/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/configs/zsh/zshrc" "$ZDOTDIR/.zshrc"

# Generate new completions
zsh $DOTFILES/configs/zsh/scripts/generate_completions.zsh

