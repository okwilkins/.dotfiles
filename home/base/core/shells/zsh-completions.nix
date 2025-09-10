{ pkgs, projectVars, ... }:
let
  gen-completion =
    {
      name,
      command,
      packages ? [ ],
    }:
    pkgs.runCommand "${name}-completion.zsh" {
      nativeBuildInputs = packages;
    } command;

  dockerCompletion = gen-completion {
    name = "docker";
    command = "${pkgs.docker}/bin/docker completion zsh > $out";
    packages = [ pkgs.docker ];
  };
  kubectlCompletion = gen-completion {
    name = "kubectl";
    command = "${pkgs.kubectl}/bin/kubectl completion zsh > $out";
    packages = [ pkgs.kubectl ];
  };
  zoxideCompletion = gen-completion {
    name = "zoxide";
    command = "${pkgs.zoxide}/bin/zoxide init zsh > $out";
    packages = [ pkgs.zoxide ];
  };
  # TODO: Install Dagger via its Flake as not available via pkgs
  # daggerCompletion = gen-completion {
  #   name = "dagger";
  #   command = "${pkgs.dagger}/bin/dagger completion zsh > $out";
  #   packages = [ pkgs.dagger ];
  # };
in
{
  home.file."${projectVars.xdg.configDir}/zsh/completions/docker-completion.sh" = {
    source = dockerCompletion;
  };
  home.file."${projectVars.xdg.configDir}/zsh/completions/kubectl-completion.sh" = {
    source = kubectlCompletion;
  };
  home.file."${projectVars.xdg.configDir}/zsh/completions/zoxide-completion.sh" = {
    source = zoxideCompletion;
  };
  # home.file."${projectVars.xdg.configDir}/zsh/test/dagger-completion.sh" = {
  #   source = daggerCompletion;
  # };
}
