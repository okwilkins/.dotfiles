{ osConfig, ... }:
{
  programs.neovim = {
    enable = true;
  };
  home.file."${osConfig.system.xdg.configDir}/nvim" = {
    source = ./neovim;
    recursive = true;
  };
}
