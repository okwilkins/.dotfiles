{ pkgs, projectVars, ... }:
{
  home.packages = with pkgs; [
    jankyborders
  ];

  home.file."${projectVars.xdg.configDir}/borders/bordersrc" = {
    source = ./borders.bash;
  };
}
