{
  nixpkgs,
  home-manager,
  sops-nix,
  inputs,
  overlays,
  ...
}:
let
  mkAspen =
    system:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ../../../hosts/home-aspen
        ../../../modules/linux/base
        ../../../config
        ../../../generators/docker.nix
        sops-nix.nixosModules.sops
        (
          { ... }:
          {
            nixpkgs.overlays = overlays;
          }
        )
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Backup conflicting files when switching to not cause errors
          home-manager.backupFileExtension = "backup";
          home-manager.users.oli.imports = [
            ../../../home/base/home.nix
            ../../../home/base/core
            ../../../home/base/tui
            ../../../home/linux/sops.nix
            ../../../home/linux/yubikey.nix
          ];
        }
      ];
    };
in
{
  nixosConfigurations.aspen = mkAspen "x86_64-linux";
  nixosConfigurations.aspen-aarch64 = mkAspen "aarch64-linux";
}
