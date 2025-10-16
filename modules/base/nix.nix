{ lib, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Garbage collect weekly to keep disk space
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 7;
      Hour = 2;
      Minute = 00;
    };
    options = "--delete-older-than +7d";
  };
}
