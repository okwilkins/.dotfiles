{
  nix-darwin,
  home-manager-darwin,
  ...
}@inputs:
{
  darwinConfigurations.hamming = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      ../../../hosts/work-hamming
      ../../../modules/darwin/base
      ../../../config
      home-manager-darwin.darwinModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Backup conflicting files when switching to not cause errors
        home-manager.backupFileExtension = "backup";
        home-manager.users."oliver.wilkins".imports = [
          ../../../home/base
          ../../home/darwin
        ];
      }
    ];
  };
}
