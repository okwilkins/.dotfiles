# Generates new completions found in the zsh/completions directory

docker completion zsh > $DOTFILES/configs/zsh/completions/_docker
kubectl completion zsh > $DOTFILES/configs/zsh/completions/_kubectl 
devbox completion zsh > $DOTFILES/configs/zsh/completions/_devbox
zoxide init zsh > $DOTFILES/configs/zsh/completions/_zoxide 

