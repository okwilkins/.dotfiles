{
  nix-darwin,
  home-manager-darwin,
  ...
}@inputs:
import ./systems/work-hamming.nix {
  inherit
    inputs
    nix-darwin
    home-manager-darwin
    ;
}
