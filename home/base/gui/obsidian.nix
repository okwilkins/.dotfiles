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

  obsidianGit = pkgs.fetchzip {
    url = "https://github.com/Vinzent03/obsidian-git/releases/download/2.35.2/obsidian-git-2.35.2.zip";
    name = "obsidian-git";
    stripRoot = false;
    hash = "sha256-FKpNQu5AUhYa62NWAt2MX0fmIUXuHyx05e3F3txW8Sw=";
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
        settings = {
          app = {
            safeMode = false;
            vimMode = true;
            showLineNumber = true;
          };
          communityPlugins = [
            obsidianGitRepo
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
      };
    };
  };
}
