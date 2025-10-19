{ pkgs, ... }:
{
  imports = [
    ./aerospace
    ./karabiner-elements
  ];

  home.packages = with pkgs; [
    raycast
  ];
}
