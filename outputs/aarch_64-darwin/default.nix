{ nix-darwin, home-manager-darwin, ... }@inputs:
let
  hammingSystem = import ./systems/work-hamming.nix {
    inherit nix-darwin home-manager-darwin inputs;
  };
in
{
  outputs = {
    nixosConfigurations = {
      hamming = hammingSystem.nixosConfigurations;
    };
  };
}
