{ ... }:
{
  imports = [
    ./system-packages.nix
    ./system-variables.nix
    ./nix.nix
    ./ssh.nix
    ./security.nix
  ];
}
