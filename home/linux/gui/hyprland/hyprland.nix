{ projectVars, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprshot
    hyprlock
  ];
  home.file."${projectVars.xdg.configDir}/hypr/" = {
    source = ./configs;
    recursive = true;
  };
}
