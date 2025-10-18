{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [
    karabiner-elements
  ];

  home.file."${osConfig.system.xdg.configDir}/karabiner/karabiner.json" = {
    source = ./karabiner.json;
  };
}
