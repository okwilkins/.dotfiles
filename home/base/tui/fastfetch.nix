{ pkgs, projectVars, ... }:
{
  home.packages = [ pkgs.fastfetch ];
  home.file."${projectVars.xdg.configDir}/fastfetch" = {
    source = ./fastfetch;
    recursive = true;
  };
}
