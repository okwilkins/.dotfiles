{ nixpkgs, ... }:
{
  imports = [
    ../../../home/base/core/cli-tools.nix
    nixpkgs
  ];
  nixosConfigurations = {
    "oak" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../../../systems/home-oak
        ../../../modules/base
        ../../../home/base/home.nix
      ];
    };
  };
}
