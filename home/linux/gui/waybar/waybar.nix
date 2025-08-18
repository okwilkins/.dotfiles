{ pkgs, projectVars, ... }:
{
  home.packages = with pkgs; [ waybar ];
  home.file."${projectVars.xdg.configDir}/waybar" = {
    source = ./config;
    recursive = true;
  };
}
