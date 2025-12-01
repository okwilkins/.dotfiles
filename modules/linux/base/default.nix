{ ... }:
{
  imports = [
    ../../base
    ./i18n.nix
    ./ssh.nix
    ./nix.nix
    ./system-packages.nix
    ./security.nix
    ./virtualisation.nix
  ];
}
