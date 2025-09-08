{ pkgs, projectVars, ... }:
{
  home.packages = with pkgs; [ anyrun ];
  home.file."${projectVars.xdg.configDir}/anyrun" = {
    source = ./config;
    recursive = true;
  };
}
