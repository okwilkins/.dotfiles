{ pkgs, osConfig, ... }:
let
  registryHost = "harbor.okwilkins.dev";
  tomlFormat = pkgs.formats.toml { };
  caStorePath = pkgs.writeText "talos-homelab-ca.crt" (
    builtins.readFile ../../../../certs/talos-homelab-ca.crt
  );

  buildkitConfig = {
    registry = {
      "${registryHost}" = {
        ca = [ caStorePath ];
      };
    };
  };
  buildkitToml = tomlFormat.generate "buildkit.default.toml" buildkitConfig;
in
{
  home.sessionVariables.BUILDX_CONFIG = "${osConfig.system.xdg.configHome}/buildx";
  home.file."${osConfig.system.xdg.configDir}/buildx/buildkit.default.toml".source = buildkitToml;
}
