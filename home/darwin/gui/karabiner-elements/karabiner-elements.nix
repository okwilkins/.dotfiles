{ pkgs, projectVars, ... }:
{
  home.packages = with pkgs; [
    karabiner-elements
  ];

  home.file."${projectVars.xdg.configDir}/karabiner/karabiner.json" = {
    source = ./karabiner.json;
  };
}
