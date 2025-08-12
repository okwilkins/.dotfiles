{ pkgs, projectVars, ... }:
{
  home.packages = [ pkgs.rainfrog ];
  home.file."${projectVars.xdg.configDir}/rainfrog" = {
    source = ./rainfrog;
    recursive = true;
  };
}
