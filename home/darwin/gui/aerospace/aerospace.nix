{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [
    aerospace
  ];

  home.file."${osConfig.system.xdg.configDir}/aerospace/aerospace.toml" = {
    source = ./aerospace.toml;
  };
}
