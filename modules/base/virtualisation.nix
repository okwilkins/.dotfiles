{ config, ... }:
{
  virtualisation.docker.enable = true;
  users.users.${config.system.username}.extraGroups = [ "docker" ];
}
