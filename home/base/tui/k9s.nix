{ pkgs, projectVars, ... }: {
  home.packages = [ pkgs.k9s ];
  home.file."${projectVars.xdg.configDir}/k9s" = {
    source = ./k9s;
    recursive = true;
  };
}
