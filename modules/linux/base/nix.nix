{ ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Garbage collect weekly to keep disk space
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than +7d";
  };
}
