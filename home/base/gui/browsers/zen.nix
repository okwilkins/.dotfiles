{ inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;
    profiles.default = {
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
