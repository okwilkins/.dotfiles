{ osConfig, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        identityFile = "${osConfig.system.homeDir}/.ssh/oli";
      };
    };
  };
}
