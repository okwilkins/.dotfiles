{
  nix-darwin,
  home-manager,
  inputs,
  overlays,
  ...
}:
import ./systems/work-hamming.nix {
  inherit
    inputs
    nix-darwin
    home-manager
    overlays
    ;
}
