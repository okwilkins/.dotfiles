{ config, pkgs, ... }:
{
  programs.ssh = {
    knownHosts = config.knownHosts;
  };

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
    dispatcherScripts = [
      {
        # Disable IPv6 when a VPN is enabled as with NordVPN IPv6 is leaking as un-VPNed IP
        # https://nixsanctuary.com/how-to-prevent-ipv6-leak-with-an-openvpn-client-on-gnu-linux/
        source = pkgs.writeText "vpn-ipv6-block" ''
          #!/bin/sh
          case "$2" in
            vpn-up)
              ${pkgs.procps}/bin/sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
              ${pkgs.procps}/bin/sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
              ;;
            vpn-down)
              ${pkgs.procps}/bin/sysctl -w net.ipv6.conf.all.disable_ipv6=0 >/dev/null 2>&1
              ${pkgs.procps}/bin/sysctl -w net.ipv6.conf.default.disable_ipv6=0 >/dev/null 2>&1
              ;;
          esac
        '';
        type = "basic";
      }
    ];
  };

}
