{ projectVars, pkgs, ... }:
{
  home.packages = with pkgs; [ hyprpaper ];
  home.file."${projectVars.xdg.configDir}/hypr/" = {
    source = ./configs;
    recursive = true;
  };
}
