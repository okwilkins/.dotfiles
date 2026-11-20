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

      read -r width height refresh < <(
        hyprctl monitors -j | jq -er '.[] | select(.focused) | [.width, .height, (.refreshRate | round)] | @tsv'
      )
      # Disable explicit sync for NVIDIA mouse stutter: https://github.com/ValveSoftware/gamescope/issues/1626
      exec env -u SDL_VIDEODRIVER \
        gamescope_drm_debug_disable_explicit_sync=true \
        ${lib.getExe pkgs.gamescope} --backend wayland -e -f \
        -W "$width" \
        -H "$height" \
        -r "$refresh" \
        -- ${steam} -gamepadui "$@"
    '';
  };
in
{
  config = lib.mkIf osConfig.programs.steam.enable {
    home.packages = [ steamGamescope ];

    xdg.desktopEntries.steam-tv = {
      name = "Steam (TV)";
      comment = "Steam Big Picture in Gamescope with focused monitor settings";
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
