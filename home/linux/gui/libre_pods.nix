{
  inputs,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  librepodsPkgs = inputs.librepods.inputs.nixpkgs.legacyPackages.${system};
  addMicDeps = old: {
    buildInputs = old.buildInputs ++ [ librepodsPkgs.ffmpeg_8 ];
    nativeBuildInputs = old.nativeBuildInputs ++ [ librepodsPkgs.rustPlatform.bindgenHook ];
  };
  librepods = inputs.librepods.packages.${system}.default.overrideAttrs (
    old: addMicDeps old // { cargoArtifacts = old.cargoArtifacts.overrideAttrs addMicDeps; }
  );
in
{
  home.packages = [ librepods ];

  xdg.configFile."librepods/app_settings.json".source = ./librepods/app_settings.json;

  xdg.desktopEntries.librepods = {
    name = "LibrePods";
    exec = "${librepods}/bin/librepods --start-minimized";
    icon = "${inputs.librepods}/linux-rust/assets/icon.png";
    categories = [
      "AudioVideo"
      "Audio"
    ];
  };
}
