{ ... }:
{
  virtualisation.docker.enable = true;
  users.users.oli.extraGroups = [ "docker" ];
}
