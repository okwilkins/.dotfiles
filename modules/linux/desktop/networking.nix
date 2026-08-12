{ config, pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    extraSetFlags = [ "--operator=${config.system.username}" ];
  };

  # Boot with tailscale disconnected (daemon still runs); connect manually,
  # e.g. from the noctalia plugin.
  systemd.services.tailscale-down-at-boot = {
    description = "Keep tailscale disconnected at boot";
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.tailscale}/bin/tailscale down
    '';
  };
}
