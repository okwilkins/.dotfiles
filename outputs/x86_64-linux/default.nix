{
  nixpkgs,
  home-manager,
  inputs,
  ...
}:
import ./systems/home-oak.nix {
  inherit
    inputs
    nixpkgs
    home-manager
    ;
}
