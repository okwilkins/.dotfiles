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
in
{
  home.activation.cloneKnowledgeSystem = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${vaultPath}" ]; then
      echo "Cloning Knowledge System vault..."
      export PATH="${pkgs.openssh}/bin:$PATH"
      ${pkgs.git}/bin/git clone "${repoUrl}" "${vaultPath}"
    fi
  '';
  home.file."${relVaultPath}/.obsidian/config".text = builtins.toJSON {
    vimMode = true;
    attachmentFolderPath = "assets";
  };

  programs.obsidian = {
    enable = true;
    vaults = {
      ${relVaultPath} = {
        enable = true;
        settings = {
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
