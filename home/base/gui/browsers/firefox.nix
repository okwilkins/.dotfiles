# TODO: Remove this file when Zen working
{ pkgs, ... }:
let
  gwfoxRev = "2.7.20";
  gwfoxFirefoxCss = pkgs.fetchFromGitHub {
    owner = "akkva";
    repo = "gwfox";
    rev = gwfoxRev;
    sha256 = "sha256-fN0gDkIzp6lnUlZrgzCasCbMIMwO7Pc6LWJqikQkiRo=";
  };
in
{
  home.file.".mozilla/firefox/default/chrome" = {
    source = "${gwfoxFirefoxCss}/chrome";
    recursive = true;
  };
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "always";
        "sidebar.main.tools" = "tabs";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "widget.windows.mica" = true;
        "widget.windows.mica.toplevel-backdrop" = true;
        "sidebar.animation.enabled" = false;
        "widget.macos.native-context-menus" = false;
        "gwfox.plus" = true;
      };
    };
  };
}
