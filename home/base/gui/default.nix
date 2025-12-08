{ pkgs, ... }:
{
  imports = [
    ./terminals
    ./browsers
    ./styling
    ./images.nix
  ];

  home.packages = with pkgs; [
    obsidian
  ];
}
