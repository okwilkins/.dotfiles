{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  hex = lib.getExe config.programs.hex.package;
  launcher = pkgs.writeShellScriptBin "hex" ''
    # Bare Hex normally opens Settings. Start it in the background instead.
    if [ "$#" -eq 0 ]; then
      set -- start
    fi
    exec ${hex} "$@"
  '';
  timeout = lib.getExe' pkgs.coreutils "timeout";
  settings = builtins.fromJSON (builtins.readFile ./hex/settings.json);
  replacements = lib.concatMap (
    entry:
    map (alias: {
      matched_phrase = alias;
      output = entry.term;
    }) (entry.sounds_like or [ ])
  ) settings.vocabulary;
in
{
  imports = [ inputs.hex.homeManagerModules.hex ];

  home.packages = [ (lib.hiPrio launcher) ];

  xdg.dataFile."hex/settings.json".text = builtins.toJSON (
    lib.recursiveUpdate settings { dictation_processing.default_mode.replacements = replacements; }
  );

  xdg.dataFile."applications/anomaly.hex.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Hex
    Comment=Local voice dictation
    Exec=${hex} start
    Icon=anomaly.hex
    Terminal=false
    Categories=Utility;Accessibility;
    StartupNotify=false
    StartupWMClass=anomaly.hex
    Actions=settings;quit;

    [Desktop Action settings]
    Name=Settings
    Exec=${hex} app

    [Desktop Action quit]
    Name=Quit Hex
    Exec=${hex} quit
  '';

  systemd.user.services.hex.Service.ExecStartPost = [
    "-${timeout} -k 1s 5s ${pkgs.libnotify}/bin/notify-send --app-name=Hex --icon=anomaly.hex 'Hex started'"
  ];

  programs.hex = {
    enable = true;
    autostart = false;
    systemdTarget = "hyprland-session.target";
    installModel = true;
  };
}
