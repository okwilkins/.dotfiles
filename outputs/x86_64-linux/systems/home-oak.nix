{ nixpkgs, home-manager, ... }@inputs:
{
  nixosConfigurations.oak = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../../../hosts/home-oak
      ../../../modules/linux/desktop
      ../../../config
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Backup conflicting files when switching to not cause errors
        home-manager.backupFileExtension = "backup";
        home-manager.users.oli.imports = [
          ../../../home/base
          ../../../home/linux
          ../../../hosts/home-oak/hyprland.nix
        ];
      }
    ];
  };
}
