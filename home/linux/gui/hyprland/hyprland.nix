{ projectVars, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    hyprshot
  ];
  home.file."${projectVars.xdg.configDir}/hypr/" = {
    source = ./configs;
    recursive = true;
  };
}
