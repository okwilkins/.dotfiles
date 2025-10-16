{ nixpkgs, ... }:
{
  imports = [
    ../../../home/base/core/cli-tools.nix
    nixpkgs
  ];
  nixosConfigurations = {
    "hamming" = nixpkgs.lib.nixosSystem {
      system = "aarch-darwin";
      modules = [
        ../../../systems/home-oak
        ../../../modules/base
        ../../../home/base/home.nix
      ];
    };
  };
}
