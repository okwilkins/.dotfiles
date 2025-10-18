{ lib, ... }:
let
  brokenPackages = [
    "ghostty"
  ];
in
{
  nixpkgs.overlays = [
    (
      _: super:
      let
        removeUnwantedPackages =
          pname: lib.warn "${pname} has been removed on the darwin platform" super.emptyDirectory;
      in
      lib.genAttrs brokenPackages removeUnwantedPackages
    )
  ];
}
