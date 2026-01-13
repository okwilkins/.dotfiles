{ inputs, ... }:
{
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
  ];

  formatConfigs.docker =
    { ... }:
    {
    };
}
