{ pkgs, osConfig, ... }:
{
  home.packages = [ pkgs.fastfetch ];
  home.file."${osConfig.system.xdg.configDir}/fastfetch" = {
    source = ./fastfetch;
    recursive = true;
  };
}
