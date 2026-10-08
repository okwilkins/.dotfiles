{ pkgs, osConfig, ... }:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "gh-dash";
    rev = "ecd62f5a2b6230ba2d8fe080e31d870997c7a738";
    hash = "sha256-Pm5PkfyFqBZQ+L0cu6b66yiIE7hpT7z062xm9khxfc8=";
  };
in
{
  home.packages = [ pkgs.gh-dash ];
  home.file."${osConfig.system.xdg.configDir}/gh-dash" = {
    source = ./gh-dash;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/gh-dash/themes/catppuccin-mocha-blue.yml" = {
    source = "${catppuccinRepo}/themes/mocha/catppuccin-mocha-blue.yml";
  };
}
