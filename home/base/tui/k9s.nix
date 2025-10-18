{ pkgs, osConfig, ... }:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "k9s";
    rev = "fdbec82284744a1fc2eb3e2d24cb92ef87ffb8b4";
    hash = "sha256-9h+jyEO4w0OnzeEKQXJbg9dvvWGZYQAO4MbgDn6QRzM=";
  };
in
{
  home.packages = [ pkgs.k9s ];
  home.file."${osConfig.system.xdg.configDir}/k9s" = {
    source = ./k9s;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/k9s/skins" = {
    source = "${catppuccinRepo}/dist";
    recursive = true;
  };
}
