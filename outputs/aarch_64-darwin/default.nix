{
  nix-darwin,
  home-manager,
  inputs,
  ...
}:
import ./systems/work-hamming.nix {
  inherit
    inputs
    nix-darwin
    home-manager
    ;
}
