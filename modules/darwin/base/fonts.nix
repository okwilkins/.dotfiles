{ pkgs, ... }:
{
  fonts = {
    packages = import ../../base/fonts.nix { inherit pkgs; };
  };
}
