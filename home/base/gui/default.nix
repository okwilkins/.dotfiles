{ pkgs, ... }:
{
  imports = [
    ./terminals
    ./browsers
    ./styling
    ./images.nix
    ./obsidian.nix
  ];

  home.packages = with pkgs; [
    obs-studio
  ];
}
