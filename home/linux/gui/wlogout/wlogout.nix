{ pkgs, projectVars, ... }:
{
  home.packages = with pkgs; [ wlogout ];

  home.file."${projectVars.xdg.configDir}/wlogout" = {
    source = ./config;
    recursive = true;
  };
}
