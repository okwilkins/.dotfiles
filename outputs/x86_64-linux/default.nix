{
  nixpkgs,
  home-manager,
  inputs,
  overlays,
  sops-nix,
  ...
}:

nixpkgs.lib.recursiveUpdate
  (import ./systems/home-birch.nix {
    inherit
      inputs
      nixpkgs
      home-manager
      overlays
      sops-nix
      ;
  })
  (
    import ./systems/home-oak.nix {
      inherit
        inputs
        nixpkgs
        home-manager
        overlays
        sops-nix
        ;
    }
  )
