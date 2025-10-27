{ inputs }:
[
  (
    final: prev:
    let
      pkgs-stable = import inputs.nixpkgs-stable {
        system = prev.system;
        config.allowUnfree = true;
      };
    in
    {
      terraform = pkgs-stable.terraform;
    }
  )

  # (final: prev: {
  #   another-package = ...;
  # })
]
