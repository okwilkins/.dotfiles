{ pkgs, ... }:
{
  imports = [
    ./neovim.nix
    ./k9s.nix
    ./rainfrog.nix
  ];

  home.packages = with pkgs; [
    lazydocker
    fastfetch
  ];
}
