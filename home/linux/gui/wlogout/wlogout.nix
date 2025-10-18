{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [ wlogout ];

  home.file."${osConfig.system.xdg.configDir}/wlogout" = {
    source = ./config;
    recursive = true;
  };
}
