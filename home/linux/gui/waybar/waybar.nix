{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [ waybar ];
  home.file."${osConfig.system.xdg.configDir}/waybar" = {
    source = ./config;
    recursive = true;
  };
}
