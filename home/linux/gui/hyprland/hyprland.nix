{ osConfig, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprshot
    hyprlock
    hypridle
  ];
  home.file."${osConfig.system.xdg.configDir}/hypr/" = {
    source = ./config;
    recursive = true;
  };
}
