{ config, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    extraSetFlags = [ "--operator=${config.system.username}" ];
  };

}
