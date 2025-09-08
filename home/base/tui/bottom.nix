{ pkgs, projectVars, ... }:
{
  home.packages = [ pkgs.bottom ];
  home.file."${projectVars.xdg.configDir}/bottom" = {
    source = ./bottom;
    recursive = true;
  };
}
