{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      registry-mirrors = [ "https://harbor.okwilkins.dev" ];
    };
  };
  users.users.${config.system.username}.extraGroups = [ "docker" ];
}
