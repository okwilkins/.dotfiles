{
  nixpkgs,
  home-manager,
  inputs,
  overlays,
  ...
}:
import ./systems/home-oak.nix {
  inherit
    inputs
    nixpkgs
    home-manager
    overlays
    ;
}
