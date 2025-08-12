{ pkgs, lib, projectVars, ... }:
let
  version = "0.3.2";
  url =
    "https://github.com/ndom91/rose-pine-hyprcursor/releases/download/v${version}/rose-pine-cursor-hyprcursor_${version}.tar.gz";
  cursor-archive = pkgs.fetchurl {
    url = url;
    sha256 = "5e84afe47ef723c465317bc58710f4e45b0b36366d4d88bf0325c712b711b58e";
  };
in {
  home.activation.extractCursor = lib.hm.dag.entryAfter [ "writeBoundry" ] ''
    PATH=${lib.makeBinPath [ pkgs.gnutar pkgs.gzip ]}:$PATH
    mkdir -p ${projectVars.xdg.dataDir}/icons/rose-pine-hyprcursor
    tar -xzf ${cursor-archive} -C "${projectVars.xdg.dataDir}/icons/rose-pine-hyprcursor"
  '';
}
