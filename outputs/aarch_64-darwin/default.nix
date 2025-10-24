{ nix-darwin, home-manager-darwin, ... }@inputs:
{
  outputs = {
    nixosConfigurations = {
      hamming = import ./systems/work-hamming.nix {
        inherit nix-darwin home-manager-darwin inputs;
      };
    };
  };
}
