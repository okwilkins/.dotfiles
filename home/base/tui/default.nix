{ pkgs, ... }:
{
  imports = [
    ./neovim.nix
    ./k9s.nix
    ./rainfrog.nix
    ./fastfetch.nix
  ];

  home.packages = with pkgs; [
    lazydocker
  ];
}
