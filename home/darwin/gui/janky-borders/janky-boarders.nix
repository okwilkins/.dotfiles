{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [
    jankyborders
  ];

  home.file."${osConfig.system.xdg.configDir}/borders/bordersrc" = {
    source = ./borders.bash;
  };
}
