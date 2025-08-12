{ projectVars, ... }:
{
  programs.neovim = {
    enable = true;
  };
  home.file."${projectVars.xdg.configDir}/nvim" = {
    source = ./neovim;
    recursive = true;
  };
}
