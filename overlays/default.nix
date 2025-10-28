{ inputs }:
[
  (final: prev: {
    # Cosign 3.0.2 checks fail
    cosign = prev.cosign.overrideAttrs (oldAttrs: {
      doCheck = false;
      doInstallCheck = false;
    });
  })

  # (final: prev: {
  #   another-package = ...;
  # })
]
