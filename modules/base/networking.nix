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

  system.activationScripts.importNordvpn = {
    # WARN: Without this the system will not boot as there is not access to the secrets!
    deps = [ "setupSecrets" ];
    text = ''
      PATH=${pkgs.networkmanager}/bin:$PATH

      USERNAME=$(cat ${config.sops.secrets."nordvpn/username".path} 2>/dev/null)
      PASSWORD=$(cat ${config.sops.secrets."nordvpn/password".path} 2>/dev/null)

      if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
        echo "ERROR: NordVPN credentials missing! Sops may not have decrypted yet!" >&2
        exit 1
      fi

      for ovpn in /etc/openvpn/*.ovpn; do
        [ -f "$ovpn" ] || continue
        name=$(basename "$ovpn" .ovpn)

        if ! nmcli -t -f NAME connection show | grep -qF "$name"; then
          echo "Importing: $name"
          nmcli connection import type openvpn file "$ovpn" || continue
        fi

        nmcli connection modify "$name" \
          +vpn.data "username=$USERNAME" \
          +vpn.data "password-flags=0" \
          vpn.secrets "password=$PASSWORD" \
          connection.autoconnect no
      done
    '';
  };

}
