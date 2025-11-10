{ pkgs, osConfig, ... }:
let
  gen-plugin =
    {
      name,
      command,
      packages ? [ ],
    }:
    pkgs.runCommand "${name}-plugin.zsh" {
      nativeBuildInputs = packages;
    } command;

  dockerPlugin = gen-plugin {
    name = "docker";
    command = "${pkgs.docker}/bin/docker completion zsh > $out";
    packages = [ pkgs.docker ];
  };
  kubectlPlugin = gen-plugin {
    name = "kubectl";
    command = "${pkgs.kubectl}/bin/kubectl completion zsh > $out";
    packages = [ pkgs.kubectl ];
  };
  zoxidePlugin = gen-plugin {
    name = "zoxide";
    command = "${pkgs.zoxide}/bin/zoxide init zsh > $out";
    packages = [ pkgs.zoxide ];
  };
  fzfPlugin = gen-plugin {
    name = "fzf";
    command = "${pkgs.fzf}/bin/fzf --zsh > $out";
    packages = [ pkgs.fzf ];
  };
  carapacePlugin = gen-plugin {
    name = "carapace";
    command = "${pkgs.carapace}/bin/carapace _carapace zsh > $out";
    packages = [ pkgs.carapace ];
  };
  starshipPlugin = gen-plugin {
    name = "starship";
    command = "${pkgs.starship}/bin/starship init zsh > $out";
    packages = [ pkgs.starship ];
  };
in
{
  # INFO: Broken on Darwin 25.05
  # home.file."${osConfig.system.xdg.configDir}/zsh/plugins/docker-plugin.zsh" = {
  #   source = dockerPlugin;
  # };
  home.file."${osConfig.system.xdg.configDir}/zsh/plugins/kubectl-plugin.zsh" = {
    source = kubectlPlugin;
  };
  home.file."${osConfig.system.xdg.configDir}/zsh/plugins/zoxide-plugin.zsh" = {
    source = zoxidePlugin;
  };
  home.file."${osConfig.system.xdg.configDir}/zsh/plugins/fzf-plugin.zsh" = {
    source = fzfPlugin;
  };
  home.file."${osConfig.system.xdg.configDir}/zsh/plugins/carapace-plugin.zsh" = {
    source = carapacePlugin;
  };
  home.file."${osConfig.system.xdg.configDir}/zsh/plugins/starship-plugin.zsh" = {
    source = starshipPlugin;
  };
}
