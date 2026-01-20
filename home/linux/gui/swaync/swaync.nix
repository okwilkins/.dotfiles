{ pkgs, osConfig, ... }:
let
  catppuccinMochaSwaync = pkgs.fetchurl {
    # Upgrade to 1.X when swaync is upgraded to 0.12+
    url = "https://github.com/catppuccin/swaync/releases/download/v0.2.3/mocha.css";
    hash = "sha256-Hie/vDt15nGCy4XWERGy1tUIecROw17GOoasT97kIfc=";
  };
in
{

  # INFO: Old setup using the hyprland applications
  # home.packages = with pkgs; [
  #   swaynotificationcenter
  # ];
  # home.file."${osConfig.system.xdg.configDir}/swaync/style.css" = {
  #   source = "${catppuccinMochaSwaync}";
  # };
}
