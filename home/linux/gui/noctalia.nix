{
  inputs,
  pkgs,
  osConfig,
  ...
}:
let
  noctaliaPluginsRepo = pkgs.fetchFromGitHub {
    owner = "noctalia-dev";
    repo = "noctalia-plugins";
    rev = "cb10d233e53ac45dbc9117f0ca19e6224f3ea2d8";
    hash = "sha256-vgJj89YeiU2FQ+cXIraPx/XdiAMC9Cj+rJqC//O4Na4=";
  };

  # For security, this stops noctalia from being able to download plugins
  # Let Nix deal with the downloading so it can be compared to a hash
  # Available plugins: https://github.com/noctalia-dev/noctalia-plugins
  #                    https://noctalia.dev/plugins
  mkPlugin =
    {
      name,
      settings ? { },
      sourceUrl ? "https://github.com/noctalia-dev/noctalia-plugins",
    }:
    {
      dir = pkgs.runCommand "noctalia-plugin-${name}" { } ''
        mkdir -p $out/${name}
        cp -r ${noctaliaPluginsRepo}/${name}/. $out/${name}/
        cp ${pkgs.writeText "${name}-settings.json" (builtins.toJSON settings)} $out/${name}/settings.json
      '';
      state = {
        enabled = true;
        inherit sourceUrl;
      };
    };

  # INFO: Ensure that the plugin has the same name in here: https://github.com/noctalia-dev/noctalia-plugins
  noctaliaPlugins = {
    privacy-indicator = mkPlugin {
      name = "privacy-indicator";
      settings = {
        hideInactive = true;
        enableToast = false;
        removeMargins = false;
        iconSpacing = 4;
        activeColor = "primary";
        inactiveColor = "none";
        micFilterRegex = "";
        camFilterRegex = "";
      };
    };
  };

  pluginsDir = pkgs.runCommand "noctalia-plugins" { } ''
    mkdir -p $out
    ${builtins.concatStringsSep "\n" (
      map (p: "cp -r ${p.dir}/. $out/") (builtins.attrValues noctaliaPlugins)
    )}
  '';
in
{
  # TODO:
  # Make it so that there is no lag on start with wallpaper
  # Want widgets: mic, KeepAwake, systemMonitor
  # https://noctalia.dev/plugins/timer
  # https://noctalia.dev/plugins/tamagotchi
  # https://noctalia.dev/plugins/pomodoro (check that the timer plugin one can't do this)
  # https://noctalia.dev/plugins/polkit-agent (check that sudo in shell activates this)

  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.file."${osConfig.system.xdg.cacheDir}/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "${osConfig.system.homeDir}/Pictures/wallpapers/leaf.jpg";
    };
  };

  # Deploy colors.json directly:
  home.file."${osConfig.system.xdg.configDir}/noctalia/colors.json" = {
    text = builtins.toJSON (
      (builtins.fromJSON (builtins.readFile ./noctalia/catppuccin-sapphire.json)).dark
    );
  };

  # Manually create plugins.json
  home.file."${osConfig.system.xdg.configDir}/noctalia/plugins.json" = {
    force = true;
    text = builtins.toJSON {
      sources = [ ];
      version = 2;
      states = builtins.mapAttrs (_: p: p.state) noctaliaPlugins;
    };
  };

  home.file."${osConfig.system.xdg.configDir}/noctalia/plugins" = {
    source = pluginsDir;
    recursive = false;
  };

  programs.noctalia-shell = {
    enable = true;
    # Taken from: https://github.com/noctalia-dev/noctalia-shell/blob/6b48834dd6c3913d211476ab2f964f3fb100675e/Assets/settings-default.json
    settings = {
      appLauncher = {
        autoPasteClipboard = false;
        clipboardWrapText = true;
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        enableClipPreview = true;
        enableClipboardHistory = false;
        iconMode = "tabler";
        ignoreMouseInput = false;
        pinnedApps = [ ];
        position = "center";
        screenshotAnnotationTool = "";
        showCategories = true;
        showIconBackground = false;
        sortByMostUsed = true;
        terminalCommand = "xterm -e";
        useApp2Unit = false;
        viewMode = "list";
      };
      audio = {
        cavaFrameRate = 60;
        mprisBlacklist = [ ];
        preferredPlayer = "";
        visualizerType = "linear";
        volumeFeedback = false;
        volumeOverdrive = false;
        volumeStep = 5;
      };
      bar = {
        backgroundOpacity = 1;
        capsuleOpacity = 1;
        density = "default";
        exclusive = true;
        floating = true;
        hideOnOverview = false;
        marginHorizontal = 4;
        marginVertical = 4;
        monitors = [ ];
        outerCorners = true;
        position = "top";
        screenOverrides = [ ];
        showCapsule = false;
        showOutline = false;
        useSeparateOpacity = false;
        widgets = {
          center = [
            {
              characterCount = 2;
              colorizeIcons = false;
              enableScrollWheel = true;
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 0.8;
              id = "Workspace";
              labelMode = "index";
              showApplications = false;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
          ];
          left = [
            {
              customFont = "";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
              usePrimaryColor = false;
            }
            {
              compactMode = false;
              compactShowAlbumArt = false;
              compactShowVisualizer = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 300;
              panelShowAlbumArt = true;
              panelShowVisualizer = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = true;
              useFixedWidth = false;
              visualizerType = "linear";
            }
          ];
          right = [
            {
              blacklist = [ ];
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [ ];
            }
            {
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              id = "NotificationHistory";
              showUnreadBadge = true;
            }
            {
              displayMode = "onhover";
              id = "KeyboardLayout";
              showIcon = true;
            }
            {
              deviceNativePath = "";
              displayMode = "onhover";
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
              warningThreshold = 30;
            }
            {
              displayMode = "onhover";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              displayMode = "onhover";
              id = "Bluetooth";
            }
            {
              displayMode = "onhover";
              id = "VPN";
            }
            {
              displayMode = "onhover";
              id = "Network";
            }
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "primary";
              customIconPath = "";
              enableColorization = true;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "plugin:privacy-indicator";
            }
          ];
        };
      };
      brightness = {
        brightnessStep = 5;
        enableDdcSupport = false;
        enforceMinimum = true;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };
      colorSchemes = {
        darkMode = true;
        extractionMethod = "default";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        # predefinedScheme = "catppuccin-sapphire";
        schedulingMode = "off";
        useWallpaperColors = false;
      };
      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = true;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
        diskPath = "/";
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
      };
      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        monitorWidgets = [ ];
      };
      dock = {
        animationSpeed = 1;
        backgroundOpacity = 1;
        colorizeIcons = false;
        deadOpacity = 0.6;
        displayMode = "auto_hide";
        enabled = false;
        floatingRatio = 1;
        inactiveIndicators = false;
        monitors = [ ];
        onlySameOutput = true;
        pinnedApps = [ ];
        pinnedStatic = false;
        position = "bottom";
        size = 1;
      };
      general = {
        allowPanelsOnScreenWithoutBar = true;
        animationDisabled = false;
        animationSpeed = 1;
        avatarImage = "${osConfig.system.homeDir}/Pictures/profiles/headshot-profile.png";
        boxRadiusRatio = 1;
        compactLockScreen = false;
        # Same as Hyprland's noctalia-blur layerrule
        dimmerOpacity = 0.35;
        enableLockScreenCountdown = true;
        enableShadows = false;
        forceBlackScreenCorners = false;
        iRadiusRatio = 1;
        language = "";
        lockOnSuspend = true;
        lockScreenCountdownDuration = 10000;
        radiusRatio = 1;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showChangelogOnStartup = true;
        showHibernateOnLockScreen = false;
        showScreenCorners = false;
        showSessionButtonsOnLockScreen = true;
        telemetryEnabled = false;
        lockScreenBlur = 0.6;
        lockScreenAnimations = true;
        # Cool password chars on lockscreen
        passwordChars = true;
      };
      hooks = {
        darkModeChange = "";
        enabled = false;
        performanceModeDisabled = "";
        performanceModeEnabled = "";
        screenLock = "";
        screenUnlock = "";
        session = "";
        wallpaperChange = "";
      };
      location = {
        analogClockInCalendar = false;
        firstDayOfWeek = 1;
        hideWeatherCityName = false;
        hideWeatherTimezone = false;
        name = "London, England";
        showCalendarEvents = true;
        showCalendarWeather = true;
        showWeekNumberInCalendar = false;
        "use12hourFormat" = false;
        useFahrenheit = false;
        weatherEnabled = true;
        weatherShowEffects = true;
      };
      network = {
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        bluetoothRssiPollIntervalMs = 10000;
        bluetoothRssiPollingEnabled = true;
        wifiDetailsViewMode = "grid";
        wifiEnabled = true;
      };
      vpn = { };
      nightLight = {
        autoSchedule = false;
        enabled = true;
        forced = false;
        manualSunrise = "06:00";
        manualSunset = "21:00";
        dayTemp = "6500";
        nightTemp = "4000";
      };
      notifications = {
        backgroundOpacity = 1;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        enableMediaToast = false;
        enabled = true;
        location = "top_right";
        lowUrgencyDuration = 3;
        monitors = [ ];
        normalUrgencyDuration = 8;
        overlayLayer = true;
        respectExpireTimeout = false;
        saveToHistory = {
          critical = true;
          low = true;
          normal = true;
        };
        sounds = {
          criticalSoundFile = "";
          enabled = false;
          excludedApps = "discord,firefox,chrome,chromium,edge";
          lowSoundFile = "";
          normalSoundFile = "";
          separateSounds = false;
          volume = 0.5;
        };
      };
      osd = {
        autoHideMs = 2000;
        backgroundOpacity = 1;
        enabled = true;
        enabledTypes = [
          0
          1
          2
        ];
        location = "top_right";
        monitors = [ ];
        overlayLayer = true;
      };
      sessionMenu = {
        countdownDuration = 3000;
        enableCountdown = true;
        largeButtonsLayout = "grid";
        largeButtonsStyle = false;
        showKeybinds = false;
        position = "center";
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "hibernate";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "reboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
        ];
        showHeader = false;
      };
      settingsVersion = 41;
      systemMonitor = {
        cpuCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        cpuWarningThreshold = 80;
        criticalColor = "";
        diskCriticalThreshold = 90;
        diskPollingInterval = 3000;
        diskWarningThreshold = 80;
        enableDgpuMonitoring = false;
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        gpuCriticalThreshold = 90;
        gpuPollingInterval = 3000;
        gpuWarningThreshold = 80;
        loadAvgPollingInterval = 3000;
        memCriticalThreshold = 90;
        memPollingInterval = 3000;
        memWarningThreshold = 80;
        networkPollingInterval = 3000;
        swapCriticalThreshold = 90;
        swapWarningThreshold = 80;
        tempCriticalThreshold = 90;
        tempPollingInterval = 3000;
        tempWarningThreshold = 80;
        useCustomColors = false;
        warningColor = "";
      };
      templates = {
        activeTemplates = [ ];
        enableUserTheming = false;
      };
      ui = {
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
        fontDefault = "Inter";
        fontDefaultScale = 1;
        fontFixed = "Noto Sans Mono";
        fontFixedScale = 1;
        networkPanelView = "wifi";
        panelBackgroundOpacity = 0.76;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        tooltipsEnabled = true;
        wifiDetailsViewMode = "grid";
        translucentWidgets = true;
      };
      wallpaper = {
        directory = "${osConfig.system.homeDir}/Pictures/wallpapers";
        enableMultiMonitorDirectories = false;
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        monitorDirectories = [ ];
        overviewEnabled = false;
        panelPosition = "follow_bar";
        randomEnabled = false;
        randomIntervalSec = 300;
        recursiveSearch = false;
        setWallpaperOnAllMonitors = true;
        solidColor = "#1a1a2e";
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = "random";
        useSolidColor = false;
        useWallhaven = false;
        wallhavenApiKey = "";
        wallhavenCategories = "111";
        wallhavenOrder = "desc";
        wallhavenPurity = "100";
        wallhavenQuery = "";
        wallhavenRatios = "";
        wallhavenResolutionHeight = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenSorting = "relevance";
        wallpaperChangeMode = "random";
        skipStartupTransition = false;
      };
      idle = {
        enabled = true;
        screenOffTimeout = 600;
        lockTimeout = 900;
        suspendTimeout = 1800;
        fadeDuration = 5;
        screenOffCommand = "hyprctl dispatch dpms off";
        resumeScreenOffCommand = "hyprctl dispatch dpms on";
        lockCommand = "";
        suspendCommand = "";
        resumeLockCommand = "";
        resumeSuspendCommand = "";
      };
    };
  };
}
