{
  pkgs,
  config,
  lib,
  ...
}:
let
  homeFiles = config.home-manager.users.${config.system.username}.home.file;
  avatar = homeFiles."Pictures/profiles/headshot-profile.png".source;
in
{
  # Set only IconFile through AccountsService, preserving other account properties.
  systemd.services.accounts-service-avatar = lib.mkIf config.services.accounts-daemon.enable {
    description = "Set the AccountsService user photo";
    wantedBy = [ "greetd.service" ];
    requires = [ "accounts-daemon.service" ];
    after = [ "accounts-daemon.service" ];
    before = [ "greetd.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      userPath=$(${pkgs.systemd}/bin/busctl --system --json=short call \
        org.freedesktop.Accounts /org/freedesktop/Accounts \
        org.freedesktop.Accounts FindUserByName s ${lib.escapeShellArg config.system.username} \
        | ${pkgs.jq}/bin/jq -er '.data[0]')
      ${pkgs.systemd}/bin/busctl --system call \
        org.freedesktop.Accounts "$userPath" org.freedesktop.Accounts.User \
        SetIconFile s "${avatar}"
    '';
  };
}
