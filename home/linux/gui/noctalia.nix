{
  inputs,
  pkgs,
  osConfig,
  ...
}:
let
  communityPluginsRepo = pkgs.fetchFromGitHub {
    owner = "noctalia-dev";
    repo = "community-plugins";
    rev = "093661f688847ffd7a47d3fdfa39c9b6f63a3a36";
    hash = "sha256-DVlvf1bjUia35aOo7M7LKQxTS+xTkF0OpqzJHK3qjWk=";
  };

  communityPlugins = pkgs.runCommand "noctalia-community-plugins" { } ''
    mkdir -p $out
    cp -r ${communityPluginsRepo}/tailscale/. $out/tailscale/
  '';

  # https://github.com/NixOS/branding generates the NixOS logo assets; use the
  # official logomark instead of the legacy nixos-icons snowflake.
  nixLogo =
    inputs.branding.legacyPackages.${pkgs.stdenv.hostPlatform.system}.nixos-branding.artifacts.internal.nixos-logomark-default-gradient-none;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    customPalettes = {
      catppuccin-sapphire = builtins.fromJSON (builtins.readFile ./noctalia/catppuccin-sapphire.json);
    };

    settings = {
      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "catppuccin-sapphire";
      };

      bar.default = {
        position = "top";
        # v4 useSeparateOpacity = false made the bar inherit panelBackgroundOpacity.
        background_opacity = 0.76;
        margin_edge = 4;
        margin_ends = 4;
        thickness = 31;
        padding = 12;
        widget_spacing = 8;
        # v4 NText used Inter Medium; 9.92pt at 96 DPI is about 13.23px.
        font_weight = 500;
        font_scale = 0.945;
        shadow = false;
        start = [
          "clock"
          "media"
          "privacy"
        ];
        center = [ "workspaces" ];
        end = [
          "tray"
          "notifications"
          "keyboard_layout"
          "battery"
          "volume"
          "bluetooth"
          "davemhammer/tailscale:status"
          "network"
          "control-center"
        ];
      };

      widget = {
        clock = {
          format = "{:%H:%M %a, %b %d}";
          vertical_format = "{:%H %M - %d %m}";
          tooltip_format = "{:%H:%M %a, %b %d}";
        };
        workspaces = {
          label_source = "id";
          max_label_chars = 2;
          labels_only_when_occupied = true;
          hide_when_empty = false;
          show_icons = false;
          focused_output_only = false;
        };
        media = {
          hide_when_no_media = true;
          max_length = 300;
          title_scroll = "on_hover";
          artist_first = true;
          show_progress = true;
        };
        privacy = {
          hide_inactive = true;
          icon_spacing = 4;
          active_color = "primary";
        };
        tray = {
          drawer = true;
          hide_passive = false;
        };
        control-center.custom_image = "${nixLogo}/nixos-logomark-default-gradient-none.svg";
        control-center.custom_image_colorize = true;
        # v5 has no hover-expanding labels; keep the compact v4 idle layout.
        # Values remain available in hover tooltips and the corresponding panels.
        keyboard_layout.show_label = false;
        battery.show_label = false;
        bluetooth.show_label = false;
        network.show_label = false;
        "davemhammer/tailscale:status".show_counts = false;
        volume = {
          show_label = false;
          actions.middle = "exec pwvucontrol || pavucontrol";
        };
      };

      battery.warning_threshold = 30;
      brightness = {
        enable_ddcutil = false;
        minimum_brightness = 0.01;
      };
      audio = {
        enable_overdrive = false;
        enable_sounds = false;
        enable_volume_sounds = false;
        enable_notification_sounds = false;
        enable_power_sounds = false;
        enable_screenshot_sounds = false;
      };
      desktop_widgets.enabled = false;
      dock.enabled = false;

      shell = {
        font_family = "Inter";
        avatar_path = "${osConfig.system.homeDir}/Pictures/profiles/headshot-profile.png";
        polkit_agent = true;
        # v4 passwordChars = true; v5 masks with random icons per char
        password_style = "random";
        # Match old hyprshot: --clipboard-only, no files
        screenshot.save_to_file = false;
        screenshot.copy_to_clipboard = true;
        clipboard_enabled = false;
        clipboard_auto_paste = "off";
        telemetry_enabled = false;
        card_borders = false;
        popup_borders = false;
        popup_shadows = false;
        panel = {
          open_near_click_control_center = true;
          # v5 presets fix floating panel opacity: soft = 0.80, glass = 0.55.
          # Soft is closest to v4's 0.76 and keeps inner cards translucent.
          transparency_mode = "soft";
          borders = false;
          shadow = false;
          session_placement = "floating";
          session_position = "center";
        };
        launcher = {
          sort_by_usage = true;
          app_grid = false;
          auto_paste = "off";
        };
      };

      lockscreen = {
        enabled = true;
        lock_before_suspend = true;
        blur_intensity = 0.6;
        # v4's pre-lock countdown has no v5 equivalent. A passwordless unlock
        # grace period is not a substitute for it.
        grace_period_seconds = 0;
      };

      wallpaper = {
        enabled = true;
        directory = "${osConfig.system.homeDir}/Pictures/wallpapers";
        fill_mode = "crop";
        fill_color = "#000000";
        transition_duration = 1500;
        edge_smoothness = 0.05;
        transition_on_startup = true;
      };
      wallpaper.default.path = "${osConfig.system.homeDir}/Pictures/wallpapers/leaf.jpg";

      notification = {
        position = "top_right";
        layer = "overlay";
        background_opacity = 1.0;
        # v5 only overrides durations per sender, not per urgency: keep its
        # timeout policy rather than applying v4's normal 8s to critical alerts.
      };

      osd = {
        enabled = true;
        position = "top_right";
        hide_delay_ms = 2000;
        background_opacity = 1.0;
        kinds = {
          volume = true;
          volume_output = true;
          volume_input = true;
          brightness = true;
          keyboard_layout = true;
          media = false;
          privacy = false;
          wifi = false;
          bluetooth = false;
          power_profile = false;
          caffeine = false;
          nightlight = false;
          dnd = false;
          lock_keys = false;
          keyboard_backlight = false;
        };
      };

      system.monitor = {
        cpu_usage_activity_threshold = 80;
        cpu_usage_critical_threshold = 90;
        cpu_temp_activity_threshold = 80;
        cpu_temp_critical_threshold = 90;
        gpu_usage_activity_threshold = 80;
        gpu_usage_critical_threshold = 90;
        gpu_temp_activity_threshold = 80;
        gpu_temp_critical_threshold = 90;
        ram_pct_activity_threshold = 80;
        ram_pct_critical_threshold = 90;
        swap_pct_activity_threshold = 80;
        swap_pct_critical_threshold = 90;
        disk_used_pct_activity_threshold = 80;
        disk_used_pct_critical_threshold = 90;
        cpu_poll_seconds = 3;
        gpu_poll_seconds = 3;
        memory_poll_seconds = 3;
        network_poll_seconds = 3;
        disk_poll_seconds = 3;
      };

      control_center.shortcuts = [
        { type = "wifi"; }
        { type = "bluetooth"; }
        { type = "wallpaper"; }
        { type = "notification"; }
        # v5 only displays six shortcuts; power profiles remain in the Power tab.
        { type = "caffeine"; }
        { type = "nightlight"; }
      ];

      shell.session = {
        show_shortcuts = false;
        actions = [
          {
            action = "lock";
            enabled = true;
            countdown_seconds = 3;
          }
          {
            action = "suspend";
            enabled = true;
            countdown_seconds = 3;
          }
          {
            action = "hibernate";
            enabled = true;
            countdown_seconds = 3;
          }
          {
            action = "reboot";
            enabled = true;
            countdown_seconds = 3;
          }
          {
            action = "logout";
            enabled = true;
            countdown_seconds = 3;
          }
          {
            action = "shutdown";
            enabled = true;
            countdown_seconds = 3;
          }
        ];
      };

      # Night light follows the location schedule
      nightlight = {
        enabled = true;
        temperature_day = 6500;
        temperature_night = 4000;
      };
      location = {
        address = "London, England";
        custom_schedule = true;
        sunrise = "06:00";
        sunset = "21:00";
      };

      weather = {
        enabled = true;
        effects = true;
      };

      idle = {
        pre_action_fade_seconds = 5;
        behavior.screen-off = {
          timeout = 600;
          action = "screen_off";
          enabled = true;
        };
        behavior.lock = {
          timeout = 900;
          action = "lock";
          enabled = true;
        };
        behavior.suspend = {
          timeout = 1800;
          action = "lock_and_suspend";
          enabled = true;
        };
      };

      plugins = {
        auto_update = "none";
        enabled = [
          "davemhammer/tailscale"
        ];
        source = [
          {
            name = "nix";
            kind = "path";
            location = "${communityPlugins}";
            enabled = true;
          }
        ];
      };

      plugin_settings."davemhammer/tailscale" = {
        ssh_user = osConfig.system.username;
        refresh_interval = 10;
      };
    };
  };
}
