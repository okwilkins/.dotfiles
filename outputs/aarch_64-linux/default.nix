{
  nixpkgs,
  home-manager,
  inputs,
  overlays,
  ...
}:

nixpkgs.lib.foldl' nixpkgs.lib.recursiveUpdate { } [
  (import ./systems/work-aspen.nix {
    inherit
      inputs
      nixpkgs
      home-manager
      overlays
      ;
  })
]
