{pkgs, config, ...}: {
  imports = [
    ./system-packages.nix
    ./zsh.nix
  ];
}
