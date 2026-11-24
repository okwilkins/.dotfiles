{ pins, ... }:
{
  home.file.".mozilla/firefox/default/chrome" = {
    source = "${pins.wavefox}/chrome";
    recursive = true;
  };

  programs.firefox = {
    enable = false;
    profiles.default = {
      settings = {
        # Personal settings
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "always";
        "sidebar.main.tools" = "tabs";
        "browser.startup.homepage" = "about:blank";
        "browser.startup.page" = 3; # Launch the last tab open
        "browser.aboutConfig.showWarning" = false;
        "browser.newtab.url" = "about:blank";
        "signon.rememberSignons" = false; # Stops asking to save passwords
        "browser.shell.checkDefaultBrowser" = false;
        # Clean up new tab page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.highlights" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # CSS settings
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;
        "Style.WaveFox" = true;
        "Style.Menu-Icons-Regular" = true;
      };
    };
  };
}
