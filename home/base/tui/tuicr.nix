{ pkgs, osConfig, ... }:
{
  home.packages = [ pkgs.tuicr ];
  home.file."${osConfig.system.xdg.configDir}/tuicr" = {
    source = ./tuicr;
    recursive = true;
  };
}
