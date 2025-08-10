{ projectVars, ... }: {
  programs.ghostty = { enable = true; };
  home.file."${projectVars.xdg.configDir}/ghostty/config" = {
    source = ./ghostty/config;
  };
}
