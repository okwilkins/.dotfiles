{ pkgs, osConfig, ... }:
{
  home.packages = [ pkgs.rainfrog ];
  home.file."${osConfig.system.xdg.configDir}/rainfrog" = {
    source = ./rainfrog;
    recursive = true;
  };
}
