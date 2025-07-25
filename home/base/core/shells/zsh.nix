{ ... }: {
  programs.zsh = { enable = true; };
  home.file.".zshenv" = { source = ./zsh/zshenv; };
  home.file.".zshrc" = { source = ./zsh/zshrc; };
}

