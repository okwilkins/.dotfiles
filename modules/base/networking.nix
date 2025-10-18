{ config, ... }:
{
  programs.ssh = {
    knownHosts = config.knownHosts;
  };
}
