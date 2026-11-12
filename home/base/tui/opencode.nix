{
  inputs,
  pkgs,
  osConfig,
  ...
}:
{
  imports = [ ./opencode/ponytail.nix ];

  home.packages = [ pkgs.opencode ];

  home.file."${osConfig.system.xdg.configDir}/opencode/opencode.json".source =
    ./opencode/opencode.json;
  home.file."${osConfig.system.xdg.configDir}/opencode/cli.json".source = ./opencode/cli.json;
}
