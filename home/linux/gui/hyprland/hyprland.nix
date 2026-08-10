{ osConfig, pkgs, ... }:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "hyprland";
    rev = "v2.0.0";
    hash = "sha256-jGqBpSQa793phan9PeU2yXMX1nxzYClthQSeTwdqgEQ=";
  };
in
{

  home.packages = with pkgs; [
    hyprshot
    # INFO: Old setup using the hyprland applications
    # hyprpaper
    # hyprlock
    # hypridle
    # hyprlauncher
    # hyprsunset
  ];
  home.file."${osConfig.system.xdg.configDir}/hypr/" = {
    source = ./config;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/hypr/themes/catppuccin-mocha.lua" = {
    source = "${catppuccinRepo}/themes/catppuccin-mocha.lua";
  };
}
