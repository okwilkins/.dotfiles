{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  steam = lib.getExe osConfig.programs.steam.package;
  steamGamescope = pkgs.writeShellApplication {
    name = "steam-gamescope";
    runtimeInputs = [
      pkgs.jq
      pkgs.procps
      osConfig.programs.hyprland.package
    ];
    text = ''
      if pgrep -u "$UID" -x steam > /dev/null; then
        ${pkgs.libnotify}/bin/notify-send "Steam (TV)" "Quit Steam completely before starting TV mode."
        exit 1
      fi

      read -r monitor width height refresh < <(
        hyprctl monitors -j | jq -er '.[] | select(.focused) | [.id, .width, .height, (.refreshRate | round)] | @tsv'
      )
      printf -v command '%q ' ${lib.getExe pkgs.gamescope} -e -f \
        -W "$width" \
        -H "$height" \
        -r "$refresh" \
        -- ${steam} -gamepadui "$@"
      # Open Gamescope on the same monitor detected
      exec hyprctl dispatch "hl.dsp.exec_cmd($(jq -Rn --arg command "$command" '$command'), { monitor = \"$monitor\" })"
    '';
  };
in
{
  config = lib.mkIf osConfig.programs.steam.enable {
    home.packages = [ steamGamescope ];

    xdg.desktopEntries.steam-tv = {
      name = "Steam (TV)";
      comment = "Steam Big Picture in Gamescope on the focused monitor";
      exec = lib.getExe steamGamescope;
      icon = "steam";
      categories = [ "Game" ];
      startupNotify = false;
    };

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/steam" = [ "steam.desktop" ];
      "x-scheme-handler/steamlink" = [ "steam.desktop" ];
    };
  };
}
