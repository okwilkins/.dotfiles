{ osConfig, pkgs, ... }:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "hyprland";
    rev = "v1.3";
    hash = "sha256-jkk021LLjCLpWOaInzO4Klg6UOR4Sh5IcKdUxIn7Dis=";
  };
in
{
  home.packages = with pkgs; [
    hyprpaper
    hyprshot
    hyprlock
    hypridle
  ];
  home.file."${osConfig.system.xdg.configDir}/hypr/" = {
    source = ./config;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/hypr/mocha.conf" = {
    source = "${catppuccinRepo}/themes/mocha.conf";
    recursive = true;
  };
}
