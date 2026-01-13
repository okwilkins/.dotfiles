{
  nixpkgs,
  home-manager,
  nix-darwin,
  sops-nix,
  nixos-generators,
  ...
}@inputs:
let
  inherit (inputs.nixpkgs) lib;
  overlays = import ../overlays/default.nix { inherit inputs; };

  nixosSystems = {
    x86_64-linux = import ./x86_64-linux {
      inherit
        nixpkgs
        home-manager
        inputs
        sops-nix
        nixos-generators
        ;
      overlays = overlays;
    };
    # aarch64-linux = import ./aarch64-linux ({system = "aarch64-linux";});
    # riscv64-linux = import ./riscv64-linux ({system = "riscv64-linux";});
  };
  darwinSystems = {
    aarch64-darwin = import ./aarch_64-darwin {
      inherit nix-darwin home-manager inputs;
      overlays = overlays;
    };
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
  nixosConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.nixosConfigurations or { }) nixosSystemValues
  );
  darwinConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.darwinConfigurations or { }) darwinSystemValues
  );
}
