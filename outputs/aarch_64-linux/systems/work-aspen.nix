{
  nixpkgs,
  home-manager,
  inputs,
  overlays,
  ...
}:
{
  nixosConfigurations.work-aspen = nixpkgs.lib.nixosSystem {
    system = "aarch_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ../../../hosts/work-aspen
      ../../../config
      ../../../modules/base
      ../../../modules/linux/base/i18n.nix
      ../../../modules/linux/base/ssh.nix
      ../../../modules/linux/base/nix.nix
      ../../../modules/linux/base/system-packages.nix
      ../../../modules/linux/base/security.nix
      ../../../modules/linux/base/virtualisation.nix
      ../../../modules/linux/desktop/fonts.nix
      ../../../modules/linux/desktop/system-packages.nix
      ../../../modules/linux/desktop/system-variables.nix
      ../../../modules/linux/desktop/security.nix
      ../../../modules/linux/desktop/peripherals.nix
      ../../../modules/linux/desktop/services.nix
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
        home-manager.backupFileExtension = "backup";
        home-manager.users.oli.imports = [
          ../../../home/base
          ../../../home/linux
          ../../../hosts/work-aspen/hyprland.nix
        ];
      }
    ];
  };
}
