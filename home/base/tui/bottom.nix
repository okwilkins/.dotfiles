{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "eadd75acd0ecad4a58ade9a1d6daa3b97ccec07c";
    hash = "sha256-dfukdk70ug1lRGADKBnvMhkl+3tsY7F+UAwTS2Qyapk=";
  };
  base = lib.importTOML "${catppuccinRepo}/themes/mocha.toml";
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
