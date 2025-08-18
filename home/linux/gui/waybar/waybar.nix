{ pkgs, projectVars, ... }:
{
  home.packages = with pkgs; [ waybar ];
  home.file."${projectVars.xdg.configDir}/waybar/config.jsonc" = {
    source = ./config.jsonc;
    recurive = true;
  };
}
