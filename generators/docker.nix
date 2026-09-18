{
  lib,
  pkgs,
  extendModules,
  modulesPath,
  ...
}:
let
  dockerConfig = extendModules {
    modules = [
      "${modulesPath}/virtualisation/docker-image.nix"
      {
        boot.loader.grub.enable = lib.mkForce false;
        boot.loader.systemd-boot.enable = lib.mkForce false;
      }
    ];
  };
  tarball = dockerConfig.config.system.build.tarball;
in
{
  options.formats.docker = lib.mkOption {
    type = lib.types.package;
    readOnly = true;
  };
  config.formats.docker = pkgs.runCommand "docker-image" { } ''
    mkdir -p $out
    ln -s ${tarball}/tarball/*.tar.xz $out/
  '';
}
