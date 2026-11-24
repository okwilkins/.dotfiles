{ ... }:
{
  _module.args.pins = builtins.mapAttrs (
    _: pin:
    builtins.fetchTarball {
      inherit (pin) url;
      sha256 = pin.hash;
    }
  ) (builtins.fromJSON (builtins.readFile ../../npins/sources.json)).pins;

  imports = [
    ./home.nix
    ./gui
    ./tui
    ./core
  ];
}
