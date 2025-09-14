{ pkgs, projectVars, ... }:
let
  catppuccinMochaSwaync = pkgs.fetchurl {
    url = "https://github.com/catppuccin/swaync/releases/download/v0.2.3/mocha.css";
    hash = "sha256-Hie/vDt15nGCy4XWERGy1tUIecROw17GOoasT97kIfc=";
  };
in
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  home.file."${projectVars.xdg.configDir}/swaync/style.css" = {
    source = "${catppuccinMochaSwaync}";
  };
}
