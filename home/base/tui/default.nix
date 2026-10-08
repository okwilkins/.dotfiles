{ pkgs, ... }:
{
  imports = [
    ./neovim.nix
    ./k9s.nix
    ./rainfrog.nix
    ./fastfetch.nix
    ./bottom.nix
    ./yazi.nix
    ./opencode.nix
    ./tuicr.nix
  ];

  home.packages = with pkgs; [
    lazydocker
  ];
}
