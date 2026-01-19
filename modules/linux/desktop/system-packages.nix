{ pkgs, config, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    xserver.enable = false;
    # https://nixos.wiki/wiki/Greetd
    # Greetd is a minimal login manager
    # It is primarily used to start Hyprland on login
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = config.system.username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=gray;input=red";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # Core tools
    wl-clipboard
  ];
}
