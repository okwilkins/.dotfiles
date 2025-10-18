# XDG stands for "Cross-Desktop Group", with X used to mean "cross".
# It's a bunch of specifications from freedesktop.org intended to standardize desktops and
# other GUI applications on various systems (primarily Unix-like) to be interoperable:
#   https://www.freedesktop.org/wiki/Specifications/
{
  osConfig,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
    xdg-user-dirs
  ];

  xdg.configFile."mimeapps.list".force = true;
  xdg = {
    enable = true;
    cacheHome = osConfig.system.xdg.cacheHome;
    configHome = osConfig.system.xdg.configHome;
    dataHome = osConfig.system.xdg.dataHome;
    stateHome = osConfig.system.xdg.stateHome;

    # manage $XDG_CONFIG_HOME/mimeapps.list
    # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
    #  echo $XDG_DATA_DIRS
    # the system-level desktop entries can be list by command:
    #   ls -l /run/current-system/sw/share/applications/
    # the user-level desktop entries can be list by command(user ryan):
    #  ls /etc/profiles/per-user/oli/share/applications/
    mimeApps = {
      enable = true;
      # let `xdg-open` to open the url with the correct application.
      defaultApplications =
        let
          browser = [
            "zen-beta.desktop"
            "firefox.desktop"
          ];
          editor = [
            "nvim.desktop"
          ];
          imageViewer = [
            "imv.desktop"
          ];
          videoViewer = [
            "imv.desktop"
          ];
          fileBrowser = [
            "org.gnome.Nautilus.desktop"
          ];
        in
        {
          "inode/directory" = fileBrowser;

          "application/json" = browser;
          "application/pdf" = browser;

          "text/html" = browser;
          "text/xml" = browser;
          "text/plain" = editor;
          "application/xml" = browser;
          "application/xhtml+xml" = browser;
          "application/xhtml_xml" = browser;
          "application/rdf+xml" = browser;
          "application/rss+xml" = browser;
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/x-extension-xht" = browser;
          "application/x-extension-xhtml" = browser;
          "application/x-wine-extension-ini" = editor;

          "x-scheme-handler/about" = browser;
          "x-scheme-handler/ftp" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;

          "image/*" = imageViewer;
          "video/*" = videoViewer;
        };

      associations.removed = {
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
