{ ... }:
{
  imports = [
    ../../base
    ./system-packages.nix
    ./system-variables.nix
    ./security.nix
    ./steam.nix
    ./peripherals.nix
    ./services.nix
  ];
}
