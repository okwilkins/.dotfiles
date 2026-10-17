# Navigation
alias ls="exa --icons --git -a"
alias ll="exa -alh --icons --long --git"
alias lt="exa --tree --level=2 --icons --git"
alias tree="lt"
alias cat=bat
alias cd=z
alias c=clear

# Improved utils
alias find=fd
alias du=dust
alias diff=delta

# QoL for applications
alias t=talosctl
# Follow the selected repository or worktree when exiting Lazygit with q.
# Adapted from https://github.com/jesseduffield/lazygit#changing-directory-on-exit
function lazygit() {
  local dir_file exit_code
  dir_file=$(mktemp) || return

  LAZYGIT_NEW_DIR_FILE="$dir_file" command lazygit "$@"
  exit_code=$?

  if [[ -s "$dir_file" ]]; then
    builtin cd -- "$(<"$dir_file")"
  fi

  rm -f -- "$dir_file"
  return "$exit_code"
}
alias lg=lazygit
alias ld=lazydocker
alias n=nvim

# Programming
# Python
alias python=python3
alias pip=pip3

# Kubectl
alias kdelk='kubectl delete -k'
alias kak='kubectl apply -k'
