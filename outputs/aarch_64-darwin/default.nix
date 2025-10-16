{ nixpkgs, ... }@inputs:
let
  hammingSystem = import ./systems/work-hamming.nix {inherit nixpkgs inputs; };
in
{
  outputs = {
    # TODO: Temp till I can generalise this part as I dont want to manually have to do this
    nixosConfigurations = {
      hamming = oakSystem.nixosConfigurations;
    };
  };
}
