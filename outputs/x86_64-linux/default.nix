{nixpkgs, ...}@inputs: let
  # TODO: Maybe switch to using Haumea to auto import
  oakSystem = import ./systems/home-oak.nix {
    inherit nixpkgs inputs;
  };
in {
  outputs = {
    # TODO: Temp till I can generalise this part as I dont want to manaully have to do this
    nixosConfigurations = oakSystem.nixosConfigurations;
  };
}
