{ ... }:
{
  imports = [
    ../base
    ./accounts-service.nix
    ./fonts.nix
    ./system-packages.nix
    ./system-variables.nix
    ./security.nix
    ./steam.nix
    ./peripherals.nix
    ./services.nix
    ./networking.nix
  ];
}
