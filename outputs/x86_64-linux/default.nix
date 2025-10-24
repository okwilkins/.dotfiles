{ nixpkgs, home-manager, ... }@inputs:
{
  outputs = {
    nixosConfigurations = {
      # TODO: Maybe switch to using Haumea to auto import
      oak = import ./systems/home-oak.nix { inherit nixpkgs home-manager inputs; };
      birch = import ./systems/home-birch.nix { inherit nixpkgs home-manager inputs; };
    };
  };
}
