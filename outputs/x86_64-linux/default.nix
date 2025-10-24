{ nixpkgs, home-manager, ... }@inputs:
let
  # TODO: Maybe switch to using Haumea to auto import
  oakSystem = import ./systems/home-oak.nix { inherit nixpkgs home-manager inputs; };
  birchSystem = import ./systems/home-birch.nix { inherit nixpkgs home-manager inputs; };
in
{
  outputs = {
    nixosConfigurations = {
      oak = oakSystem.nixosConfigurations;
      birch = birchSystem.nixosConfigurations;
    };
  };
}
