{ inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
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
      };
    };
  };
}
