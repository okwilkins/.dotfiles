{
  nixpkgs,
  home-manager,
  nix-darwin,
  home-manager-darwin,
  ...
}@inputs:
let
  inherit (inputs.nixpkgs) lib;
  nixosSystems = {
    x86_64-linux = import ./x86_64-linux { inherit nixpkgs inputs; };
    # aarch64-linux = import ./aarch64-linux ({system = "aarch64-linux";});
    # riscv64-linux = import ./riscv64-linux ({system = "riscv64-linux";});
  };
  darwinSystems = {
    # aarch64-darwin = import ./aarch64-darwin ({system = "aarch64-darwin";});
    # x86_64-darwin = import ./x86_64-darwin ({system = "x86_64-darwin";});
  };
  allSystems = nixosSystems // darwinSystems;
  allSystemsNames = builtins.attrNames allSystems;
  nixosSystemValues = builtins.attrValues nixosSystems;
  darwinSystemValues = builtins.attrValues darwinSystems;
  allSystemValues = nixosSystemValues ++ darwinSystemValues;
in
{
  args = { inherit inputs; };
  # nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) nixosSystemValues);
  # darwinConfigurations = lib.attrsets.mergeAttrsList (map (it: it.darwinConfigurations or {}) darwinSystemValues);
  nixosConfigurations.oak = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../hosts/home-oak
      ../modules/linux/desktop
      ../vars
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Backup conflicting files when switching to not cause errors
        home-manager.backupFileExtension = "backup";
        home-manager.users.oli.imports = [
          ../home/base
          ../home/linux
          ../hosts/home-oak/hyprland.nix
        ];
      }
    ];
  };

  nixosConfigurations.birch = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../hosts/home-birch
      ../modules/linux/desktop
      ../vars
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Backup conflicting files when switching to not cause errors
        home-manager.backupFileExtension = "backup";
        home-manager.users.oli.imports = [
          ../home/base
          ../home/linux
          ../hosts/home-birch/hyprland.nix
        ];
      }
    ];
  };

  darwinConfigurations.hamming = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      ../hosts/work-hamming
      ../modules/darwin/base
      ../vars
      home-manager-darwin.darwinModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Backup conflicting files when switching to not cause errors
        home-manager.backupFileExtension = "backup";
        home-manager.users."oliver.wilkins".imports = [
          ../home/base
          ../home/darwin
        ];
      }
    ];
  };

  # nixosConfigurations.oak = import ./x86_64-linux/systems/home-oak.nix {inherit nixpkgs;};
}
