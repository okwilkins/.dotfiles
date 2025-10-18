{ ... }:
{
  imports = [
    ../../base
    ./nix.nix
    ./system.nix
    ./security.nix
    ./broken-packages.nix
    ./fonts.nix
  ];
}
