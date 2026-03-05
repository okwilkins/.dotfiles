{ inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true;
    profiles.default = {
      path = "default";
      isDefault = true;
      settings = {
        "browser.startup.page" = 3; # Launch the last tab open
        "browser.aboutConfig.showWarning" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "signon.rememberSignons" = false; # Stops asking to save passwords
        # Styling
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.transparent-windows" = true;
        "zen.theme.gradient.show-custom-colors" = true;
        "zen.theme.acrylic-elements" = true;
        "browser.tabs.allow_transparent_browser" = true;
        "zen.widget.linux.transparency" = true;
        "zen.view.grey-out-inactive-windows" = false;
      };

      # Spaces/Workspaces Configuration
      spaces = {
        nix = {
          id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          name = "Nix";
          icon = "❄️";
          position = 1000;
          theme.type = "gradient";
          theme.opacity = 0.456;
        };
      };

      pins = {
        # Essentials
        gmail = {
          id = "gmail";
          title = "Gmail";
          url = "https://mail.google.com";
          position = 0;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        youtube-music = {
          id = "youtube-music";
          title = "YouTube Music";
          url = "https://music.youtube.com/";
          position = 1;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        perplexity = {
          id = "perplexity";
          title = "Perplexity";
          url = "https://www.perplexity.ai/";
          position = 2;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        x-twitter = {
          id = "x-twitter";
          title = "X";
          url = "https://x.com/home";
          position = 3;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        github = {
          id = "github";
          title = "GitHub";
          url = "https://github.com/";
          position = 4;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        whatsapp = {
          id = "whatsapp";
          title = "WhatsApp";
          url = "https://web.whatsapp.com/";
          position = 5;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        reddit = {
          id = "reddit";
          title = "Reddit";
          url = "https://www.reddit.com/";
          position = 6;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        financial-times = {
          id = "financial-times";
          title = "Financial Times";
          url = "https://www.ft.com/";
          position = 7;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        linkedin = {
          id = "linkedin";
          title = "LinkedIn";
          url = "https://www.linkedin.com";
          position = 8;
          isEssential = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };

        # Regular pins
        messenger = {
          id = "messenger";
          title = "Messenger";
          url = "https://www.messenger.com";
          position = 9;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        telegram = {
          id = "telegram";
          title = "Telegram";
          url = "https://web.telegram.org/k/#-498955210";
          position = 10;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };

        # Homelab group
        homelab-group = {
          id = "homelab-group";
          title = "Homelab";
          url = null;
          position = 11;
          isEssential = false;
          isGroup = true;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };

        # Homelab members
        proxmox-server-01 = {
          id = "proxmox-server-01";
          title = "Proxmox 01";
          url = "https://pve1.okwilkins.dev:8006";
          position = 12;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        proxmox-server-02 = {
          id = "proxmox-server-02";
          title = "Proxmox 02";
          url = "https://pve2.okwilkins.dev:8006";
          position = 13;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        grafana = {
          id = "grafana";
          title = "Grafana";
          url = "https://grafana.okwilkins.dev";
          position = 14;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        argocd = {
          id = "argocd";
          title = "ArgoCD";
          url = "https://argocd.okwilkins.dev";
          position = 15;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        argo-workflows = {
          id = "argo-workflows";
          title = "Argo Workflows";
          url = "https://workflows.okwilkins.dev";
          position = 16;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        excalidraw = {
          id = "excalidraw";
          title = "Excalidraw";
          url = "https://draw.okwilkins.dev/";
          position = 17;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        harbor = {
          id = "harbor";
          title = "Harbor";
          url = "https://harbor.okwilkins.dev";
          position = 18;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        prometheus = {
          id = "prometheus";
          title = "Prometheus";
          url = "https://prometheus.okwilkins.dev";
          position = 19;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };
        hubble = {
          id = "hubble";
          title = "Hubble";
          url = "https://hubble.okwilkins.dev/";
          position = 20;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          folderParentId = "homelab-group";
        };

        # Other pins
        frontend-masters = {
          id = "frontend-masters";
          title = "Frontend Masters";
          url = "https://frontendmasters.com/courses/algorithms/linked-list-complexity/";
          position = 21;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        monkeytype = {
          id = "monkeytype";
          title = "Monkeytype";
          url = "https://monkeytype.com/";
          position = 22;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        keybr = {
          id = "keybr";
          title = "Keybr";
          url = "https://www.keybr.com/";
          position = 23;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
        learncpp = {
          id = "learncpp";
          title = "Learn C++";
          url = "https://www.learncpp.com/";
          position = 24;
          isEssential = false;
          workspace = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        };
      };
    };

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Preferences = {
        "browser.tabs.warnOnClose" = {
          "Value" = false;
          "Status" = "locked";
        };
      };
      # To find the key, install the addon, right-click inspect and look at the link: addons://detail/<<AUTHOR ID>>
      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4535824/darkreader-4.9.116.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4624303/bitwarden_password_manager-2025.11.1.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4504218/privacy_badger17-2025.9.2.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4550452/refined_github-25.11.22.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4371820/return_youtube_dislikes-3.0.0.18.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4531307/ublock_origin-1.67.0.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{356f451b-e441-4bf4-8683-f33a29c38cc6}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4532383/simplified_twitter-2.0.0.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
      };
    };
  };
}
