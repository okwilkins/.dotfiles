{ projectVars, ... }: {
  home.file."${projectVars.xdg.configHome}/zsh/.zshenv" = {
    source = ./zsh/zshenv;
  };
  home.file."${projectVars.xdg.configHome}/zsh/.zshrc" = {
    source = ./zsh/zshrc;
  };
}
