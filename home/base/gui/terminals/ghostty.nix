{ osConfig, ... }:
{
  programs.ghostty = {
    enable = true;
  };
  home.file."${osConfig.system.xdg.configDir}/ghostty/config" = {
    source = ./ghostty/config;
  };
}
