{ inputs, lib, ... }:
let
  pin = id: title: url: {
    inherit id title url;
    editedTitle = true;
  };
  orderedPins =
    {
      start ? 0,
      isEssential ? false,
    }:
    pins:
    builtins.listToAttrs (
      lib.imap0 (i: p: {
        name = p.id;
        value = p // {
          position = start + i;
          inherit isEssential;
        };
      }) pins
    );
  folder = id: position: pins: {
    inherit id position;
    pins = orderedPins { start = position + 1; } pins;
  };

  essentials = orderedPins { isEssential = true; } [
    (pin "gmail" "Gmail" "https://mail.google.com")
    (pin "youtube-music" "YouTube Music" "https://music.youtube.com/")
    (pin "messenger" "Messenger" "https://www.messenger.com")
    (pin "grok" "Grok" "https://grok.com/")
    (pin "x-twitter" "X" "https://x.com/home")
    (pin "github" "GitHub" "https://github.com/")
    (pin "whatsapp" "WhatsApp" "https://web.whatsapp.com/")
    (pin "reddit" "Reddit" "https://www.reddit.com/")
    (pin "telegram" "Telegram" "https://web.telegram.org/k/#-498955210")
    (pin "linkedin" "LinkedIn" "https://www.linkedin.com")
  ];

  # Use the H8s directories for groups of services and pin individual services directly.
  homelabPins = {
    Applications = folder "2f28f068-6ff7-4201-b7aa-3ed920736c07" 10 [
      (pin "personal-website" "Personal Website" "https://www.okwilkins.dev")
      (pin "git" "Git" "https://git.okwilkins.dev")
      (pin "excalidraw" "Excalidraw" "https://draw.okwilkins.dev/")
      (pin "books" "Books" "https://books.okwilkins.dev")
      (pin "convert" "Img Convert" "https://convert.okwilkins.dev")
      (pin "link" "Link" "https://link.okwilkins.dev")
    ];
    "CI/CD" = folder "47b1583e-85eb-4e46-80be-845d93a97aa2" 20 [
      (pin "argocd" "Argo CD" "https://argocd.okwilkins.dev")
      (pin "argo-workflows" "Argo Workflows" "https://workflows.okwilkins.dev")
    ];
    Observability = folder "a3145349-a2ca-4b85-ac46-45014ff853f3" 40 [
      (pin "grafana" "Grafana" "https://grafana.okwilkins.dev")
      (pin "prometheus" "Prometheus" "https://prometheus.okwilkins.dev")
    ];
    Security = folder "ab5313b1-1588-47ca-91fe-d00ad439bd12" 50 [
      (pin "auth" "Auth" "https://auth.okwilkins.dev")
      (pin "crowdsec" "CrowdSec"
        "https://app.crowdsec.net/security-engines/54978e689035435d90897245940454a9reaawmj6tqk2rg77"
      )
    ];
    hubble = (pin "hubble" "Hubble" "https://hubble.okwilkins.dev/") // {
      position = 60;
    };
    harbor = (pin "harbor" "Harbor" "https://harbor.okwilkins.dev") // {
      position = 61;
    };
  };
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      path = "default";
      isDefault = true;
      search = {
        force = true;
        default = "homelab";
        engines.homelab = {
          name = "Homelab Search";
          definedAliases = [ "@s" ];
          urls = [
            {
              template = "https://search.okwilkins.dev/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
            {
              template = "https://kagisuggest.com/api/autosuggest";
              type = "application/x-suggestions+json";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
        };
      };
      settings = {
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        "browser.startup.page" = 3; # Launch the last tab open
        "browser.aboutConfig.showWarning" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "signon.rememberSignons" = false; # Stops asking to save passwords
        # Styling
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.transparent-windows" = true;
        "zen.theme.accent-color" = "AccentColor";
        "zen.theme.gradient.show-custom-colors" = true;
        "zen.theme.acrylic-elements" = true;
        "browser.tabs.allow_transparent_browser" = true;
        "zen.widget.linux.transparency" = true;
        "zen.view.grey-out-inactive-windows" = false;
      };

      spaces.homelab = {
        id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
        name = "Homelab";
        icon = "🏠";
        position = 1000;
        theme = {
          type = "gradient";
          colors = [ ]; # No custom stops: Zen derives its colours from the system accent.
          opacity = 0.456;
          rotation = null;
          texture = 0.0;
        };
        pins = essentials // homelabPins;
      };
    };

    policies = {
      Certificates = {
        Install = [ ../../../../certs/talos-homelab-ca.crt ];
      };
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
      ExtensionSettings =
        lib.genAttrs
          [
            "addon@darkreader.org" # Dark Reader
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" # Bitwarden
            "jid1-MnnxcxisBPnSXQ@jetpack" # Privacy Badger
            "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" # Refined GitHub
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" # Return YouTube Dislike
            "uBlock0@raymondhill.net" # uBlock Origin
            "{356f451b-e441-4bf4-8683-f33a29c38cc6}" # Simplified Twitter
          ]
          (id: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${lib.escapeURL id}/latest.xpi";
            installation_mode = "force_installed";
            default_area = "menupanel";
          });
    };
  };
}
