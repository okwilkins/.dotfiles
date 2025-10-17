{ pkgs, ... }:
{
  imports = [
    ./aerospace
  ];

  home.packages = with pkgs; [
    raycast
    jankyborders
  ];
}
