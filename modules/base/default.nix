{ ... }: {
  imports = [
    ./system-packages.nix
    ./system-variables.nix
    ./i18n.nix
    ./nix.nix
    ./ssh.nix
    ./fonts.nix
  ];
}
