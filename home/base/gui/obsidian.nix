{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
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
        url = "https://github.com/Vinzent03/obsidian-git/releases/download/2.35.2/obsidian-git-2.35.2.zip";
        name = "obsidian-git";
        stripRoot = true;
        hash = "sha256-6ys4mIdlAeqABo7zTIBaH86ImqD/ywEr/SskQ5y9+Pc=";
      })
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
    vaults = {
      ${relVaultPath} = {
        enable = true;
        settings = settings;
      };
    };
  };
}
