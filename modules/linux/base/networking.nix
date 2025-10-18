{ config, ... }:
{
  # This config will be written to /etc/ssh/ssh_known_hosts
  ssh = {
    knownHosts = config.knownHosts;
  };
}
