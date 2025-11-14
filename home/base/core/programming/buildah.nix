{
  pkgs,
  osConfig,
  registryHost,
  ...
}:
let
  tomlFormat = pkgs.formats.toml { };
  registryConfig = {
    unqualified-search-registries = [
      "docker.io"
      "ghcr.io"
    ];
    registry = [
      {
        prefix = "docker.io";
        location = "${registryHost}/docker-hub-cache";
        mirror = [
          {
            location = "${registryHost}/docker-hub-cache";
            insecure = false;
          }
        ];
      }
      {
        prefix = "ghcr.io";
        location = "${registryHost}/ghcr-cache";
        mirror = [
          {
            location = "${registryHost}/ghcr-cache";
            insecure = false;
          }
        ];
      }
    ];
  };
  registryToml = tomlFormat.generate "registry.conf" registryConfig;
in
{

  home.packages = with pkgs; [
    buildah
  ];

  home.file."${osConfig.system.xdg.configDir}/containers/policy.json" = {
    source = ./buildah/config.json;
  };
  home.file."${osConfig.system.xdg.configDir}/containers/registries.conf" = {
    source = registryToml;
  };
}
