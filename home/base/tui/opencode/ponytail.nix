{ pkgs, osConfig, ... }:
let
  ponytail = pkgs.fetchFromGitHub {
    owner = "DietrichGebert";
    repo = "ponytail";
    rev = "v4.7.0";
    hash = "sha256-Q6vlkbTfBFrNFTxEwYeMe5ciOe6QdULegvExwT//gJs=";
  };
in
{
  home.file."${osConfig.system.xdg.configDir}/opencode/ponytail".source = ponytail;
  home.file."${osConfig.system.xdg.configDir}/opencode/command".source =
    "${ponytail}/.opencode/command";
  home.file."${osConfig.system.xdg.configDir}/opencode/skills/ponytail".source =
    "${ponytail}/skills/ponytail";
}
