{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  dir = "${osConfig.system.xdg.configDir}/opencode";
  npm =
    {
      package,
      version,
      hash,
      ...
    }:
    pkgs.fetchurl {
      url = "https://registry.npmjs.org/${package}/-/${builtins.baseNameOf package}-${version}.tgz";
      inherit hash;
    };

  npmPlugin =
    plugin:
    pkgs.stdenvNoCC.mkDerivation {
      pname = builtins.baseNameOf plugin.package;
      inherit (plugin) version patches;
      src = npm plugin;
      installPhase = ''
        cp -r . "$out"
        ${lib.concatMapStringsSep "\n" (dep: ''
          mkdir -p "$out/node_modules/${dep.package}"
          tar -xf ${npm dep} -C "$out/node_modules/${dep.package}" --strip-components=1
        '') (plugin.dependencies or [ ])}
      '';
    };
in
{
  home.file = {
    "${dir}/packages/opencode-vim".source = npmPlugin {
      package = "opencode-vim";
      version = "0.0.30";
      # Preserve the clipboard on cuts and match Neovim's mode colours using the active theme.
      patches = [
        ./opencode-vim-yank-only.patch
        ./opencode-vim-mode-colours.patch
      ];
      hash = "sha512-oZ48kyjFpM29hZj9rvZiJjAFiy1fI7vHnikQ6wa6by71Wqx8XQMQPQmKrvMDJMrdr4FTEpI11YzDMiJQoOJWsQ==";
      dependencies = [
        {
          package = "diff";
          version = "9.0.0";
          hash = "sha512-svtcdpS8CgJyqAjEQIXdb3OjhFVVYjzGAPO8WGCmRbrml64SPw/jJD4GoE98aR7r25A0XcgrK3F02yw9R/vhQw==";
        }
        {
          package = "@vimee/core";
          version = "0.3.0";
          hash = "sha512-aC44fw6HhmjrbJMafAk3oUZIDpFbgNebbDsWwMIFD0WwnOUZPETgzU3HYQetmwz0e38JY3I/g8CJXRQjspgJZw==";
        }
      ];
    };
  };
}
