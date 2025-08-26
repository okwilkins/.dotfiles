{ inputs, pkgs, ... }:
let
  nebulaCss = pkgs.fetchFromGitHub {
    owner = "JustAdumbPrsn";
    repo = "Zen-Nebula";
    rev = "v3.1";
    sha256 = "sha256-r0yPqyCj5IYWzD5D9J6GPzj1DjSzdv5llIs+zsaVH9A=";
  };
in
{
  # Until Zen is fully declarative, follow this for full styling
  # https://www.sameerasw.com/zen
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  home.file.".zen/default/chrome" = {
    source = "${nebulaCss}";
    recursive = true;
  };
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      settings = {
        "browser.startup.page" = 3; # Launch the last tab open
        "browser.aboutConfig.showWarning" = false;
        "signon.rememberSignons" = false; # Stops asking to save passwords
        # Styling
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.transparent-windows" = true;
        "zen.theme.gradient.show-custom-colors" = true;
        "zen.theme.acrylic-elements" = true;
        # Styling Transparent Zen v1.13.0
        "browser.tabs.allow_transparent_browser" = true;
        "zen.widget.linux.transparency" = true;
        "zen.view.grey-out-inactive-windows" = false;
        "mod.sameerasw.zen_transparent_sidebar_enabled" = true;
        "mod.sameerasw_zen_light_tint" = 2; # No light
        "mod.sameerasw_zen_animations" = 2; # Quick snap
        "mod.sameerasw.zen_no_shadow" = true;
        "mod.sameerasw.zen_notab_img_enabled" = false;
        "mod.sameerasw.zen_tab_switch_anim" = true;
        "mod.sameerasw.zen_urlbar_zoom_anim" = true;
        "mod.sameerasw.zen_trackpad_anim" = true;
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
      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4535824/darkreader-4.9.110.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "support@lastpass.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4535188/lastpass_password_manager-4.145.0.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4504218/privacy_badger17-2025.5.30.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4550452/refined_github-25.8.4.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4371820/return_youtube_dislikes-3.0.0.18.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4531307/ublock_origin-1.65.0.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
        "{91aa3897-2634-4a8a-9092-279db23a7689}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4537733/zen_internet-2.7.0.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
      };
    };
  };
}
