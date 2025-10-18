{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [ anyrun ];
  home.file."${osConfig.system.xdg.configDir}/anyrun" = {
    source = ./config;
    recursive = true;
  };
}
