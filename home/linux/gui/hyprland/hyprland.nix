{ projectVars, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprshot
    hyprlock
    hypridle
  ];
  home.file."${projectVars.xdg.configDir}/hypr/" = {
    source = ./config;
    recursive = true;
  };
}
