{ pkgs, osConfig, ... }:
{
  home.packages = [ pkgs.opencode ];
  home.file."${osConfig.system.xdg.configDir}/opencode/tui.json" = {
    source = ./opencode/tui.json;
  };
}
