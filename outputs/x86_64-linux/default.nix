{
  nixpkgs,
  home-manager,
  inputs,
  overlays,
  ...
}:

nixpkgs.lib.recursiveUpdate
  (import ./systems/home-birch.nix {
    inherit
      inputs
      nixpkgs
      home-manager
      overlays
      ;
  })
  (
    import ./systems/home-oak.nix {
      inherit
        inputs
        nixpkgs
        home-manager
        overlays
        ;
    }
  )
