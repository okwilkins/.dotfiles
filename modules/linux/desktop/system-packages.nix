{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  palette =
    (builtins.fromJSON (builtins.readFile ../../../home/linux/gui/noctalia/catppuccin-sapphire.json))
    .dark;
  greeterPalette = builtins.mapAttrs (_: key: palette.${key}) {
    primary = "mPrimary";
    on_primary = "mOnPrimary";
    secondary = "mSecondary";
    on_secondary = "mOnSecondary";
    tertiary = "mTertiary";
    on_tertiary = "mOnTertiary";
    error = "mError";
    on_error = "mOnError";
    surface = "mSurface";
    on_surface = "mOnSurface";
    surface_variant = "mSurfaceVariant";
    on_surface_variant = "mOnSurfaceVariant";
    outline = "mOutline";
    shadow = "mShadow";
    hover = "mHover";
    on_hover = "mOnHover";
  };
  homeFiles = config.home-manager.users.${config.system.username}.home.file;
  wallpaper = homeFiles."Pictures/wallpapers/leaf.jpg".source;
  blurredWallpaper =
    pkgs.runCommand "noctalia-greeter-wallpaper.png"
      {
        nativeBuildInputs = [ pkgs.imagemagick ];
      }
      ''
        magick "${wallpaper}" -blur 0x12 "png:$out"
      '';
in
{
  # Module options of noctalia-greeter, only active when `system.greeter` is set
  # to "noctalia" (see hosts). The command for greetd is then provided by the
  # module itself, otherwise the session uses tuigreet directly.
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.noctalia-greeter = {
    enable = lib.mkIf (config.system.greeter == "noctalia") true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      session.default = "hyprland";
      appearance = {
        scheme = "Synced";
        theme_mode = "dark";
        palette = greeterPalette;
        font_family = "Inter";
        password_style = "random";
        hide_logo = true;
        wallpaper = {
          path = toString blurredWallpaper;
          fill_mode = "crop";
        };
      };
      # The greeter uses Xcursor rather than Hyprcursor.
      cursor = {
        theme = "BreezeX-RosePine-Linux";
        path = "${pkgs.rose-pine-cursor}/share/icons";
        size = 24;
      };
    };
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
        }
        // lib.optionalAttrs (config.system.greeter == "tuigreet") {
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
