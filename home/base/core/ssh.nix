{ osConfig, pkgs, ... }:
{
  home.packages = [ pkgs.cloudflared ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        identityFile = "${osConfig.system.homeDir}/.ssh/oli";
      };
      "git-ssh.okwilkins.dev" = {
        user = "git";
        identityFile = "${osConfig.system.homeDir}/.ssh/oli";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };
  };
}
