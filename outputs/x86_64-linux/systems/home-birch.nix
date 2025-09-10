{ nixpkgs, ... }:
{
  imports = [
    ../../../home/base/core/cli-tools.nix
    nixpkgs
  ];
  nixosConfigurations = {
    "birch" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../../../systems/home-birch
        ../../../modules/base
        ../../../home/base/home.nix
      ];
    };
  };
}
