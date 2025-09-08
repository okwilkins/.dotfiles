{ pkgs, ... }:
{
  imports = [
    ./neovim.nix
    ./k9s.nix
    ./rainfrog.nix
    ./fastfetch.nix
    ./bottom.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    lazydocker
    cbonsai
  ];
}
