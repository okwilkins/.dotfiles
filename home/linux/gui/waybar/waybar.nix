{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [ waybar ];

  home.file."${osConfig.system.xdg.configDir}/waybar" = {
    source = ./config;
    recursive = true;
  };

  home.file."${osConfig.system.xdg.configDir}/waybar/scripts" = {
    source = ./scripts;
    recursive = true;
  };
}
