{ pkgs, ... }:
{
  imports = [
    ./aerospace
    ./karabiner-elements
    ./janky-borders
  ];

  home.packages = with pkgs; [
    raycast
  ];
}
