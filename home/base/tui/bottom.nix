{
  pkgs,
  pins,
  lib,
  osConfig,
  ...
}:
let
  base = lib.importTOML "${pins.catppuccin-bottom}/themes/mocha.toml";
  local = lib.importTOML ./bottom/bottom.toml;
  merged = lib.recursiveUpdate base local;
  tomlFormat = pkgs.formats.toml { };
  bottomToml = tomlFormat.generate "bottom.toml" merged;
in
{
  home.packages = [ pkgs.bottom ];
  home.file."${osConfig.system.xdg.configDir}/bottom/bottom.toml" = {
    source = bottomToml;
  };
}
