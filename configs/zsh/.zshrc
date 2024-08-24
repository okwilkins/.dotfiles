# Use the global Devbox
eval "$(devbox global shellenv --init-hook)"

# Navigation
setopt CORRECT # Try to correct the spelling of commands

source $DEVBOX_PACKAGES_DIR/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
source $DOTFILES/aliases/aliases
