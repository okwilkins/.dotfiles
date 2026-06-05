{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:
let
  # INFO: Obsidian is currently broken: https://github.com/NixOS/nixpkgs/issues/523846
  # Downgrade temporarily
  obsidian =
    (import inputs.nixpkgs-stable {
      inherit (pkgs) system;
      config.allowUnfree = true;
    }).obsidian;

  flashNavigation = pkgs.linkFarm "flash-navigation" [
    {
      name = "main.js";
      path = pkgs.fetchurl {
        url = "https://github.com/Erl-koenig/obsidian-flash-navigation/releases/download/1.0.8/main.js";
        hash = "sha256-aKf9nbl3mBAovHpSEPxyDT2eu3AsW9b1UtbPWOllJl8=";
      };
    }
    {
      name = "manifest.json";
      path = pkgs.fetchurl {
        url = "https://github.com/Erl-koenig/obsidian-flash-navigation/releases/download/1.0.8/manifest.json";
        hash = "sha256-XI0HYRieoq5DloNd4HOlNscj7JsFvdzgt1ej+0J4aV4=";
      };
    }
    {
      name = "styles.css";
      path = pkgs.fetchurl {
        url = "https://github.com/Erl-koenig/obsidian-flash-navigation/releases/download/1.0.8/styles.css";
        hash = "sha256-BVuZZlVO5OOqsHurVw9NUEHjr0j+4V725Xtx9EGwG3w=";
      };
    }
  ];

  relVaultPath = "Documents/projects/knowledge-system";
  vaultPath = "${osConfig.system.homeDir}/${relVaultPath}";
  repoUrl = "git@github.com:okwilkins/knowledge-system.git";

  settings = {
    app = {
      safeMode = false;
      vimMode = true;
      showLineNumber = true;
    };
    communityPlugins = [
      (pkgs.fetchzip {
        url = "https://github.com/Vinzent03/obsidian-git/releases/download/2.38.3/obsidian-git-2.38.3.zip";
        name = "Git";
        stripRoot = true;
        hash = "sha256-Bm0USEhNtRCNzt9cx7vI6mgHF+mvZEAzo9WJalBKD8U=";
      })
      flashNavigation
    ];
    corePlugins = [
      "backlink"
      "bookmarks"
      "command-palette"
      "daily-notes"
      "editor-status"
      "file-explorer"
      "file-recovery"
      "global-search"
      "graph"
      "note-composer"
      "outgoing-link"
      "outline"
      "page-preview"
      "switcher"
      "tag-pane"
      "templates"
      "word-count"
      "zk-prefixer"
    ];
  };
in
{
  home.activation.cloneKnowledgeSystem = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${vaultPath}" ]; then
      echo "Cloning Knowledge System vault..."
      export PATH="${pkgs.openssh}/bin:$PATH"
      ${pkgs.git}/bin/git clone "${repoUrl}" "${vaultPath}"
    fi
  '';

  programs.obsidian = {
    enable = true;
    package = obsidian;
    vaults = {
      ${relVaultPath} = {
        enable = true;
        settings = settings;
      };
    };
  };
}
