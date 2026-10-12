{
  inputs,
  pkgs,
  osConfig,
  ...
}:
{
  imports = [ ./opencode/ponytail.nix ];

  home.packages = [ inputs.opencode.packages.${pkgs.system}.opencode ];

  home.file."${osConfig.system.xdg.configDir}/opencode/opencode.json" = {
    source = ./opencode/opencode.json;
  };

  home.file."${osConfig.system.xdg.configDir}/opencode/tui.json" = {
    source = ./opencode/tui.json;
  };
}
