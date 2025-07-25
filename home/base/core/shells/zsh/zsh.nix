{ ... }: {
  programs.zsh = { enable = true; };
  home.file.".config/zsh/.zshenv" = {
    source = ../../../../../configs/zsh/zshenv;
  };
  home.file.".config/zsh/.zshrc" = {
    source = ../../../../../configs/zsh/zshrc;
  };
}

