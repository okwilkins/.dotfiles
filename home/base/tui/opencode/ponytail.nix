{ pkgs, osConfig, ... }:
let
  ponytail = pkgs.fetchFromGitHub {
    owner = "DietrichGebert";
    repo = "ponytail";
    rev = "v5.1.0";
    hash = "sha256-diYM3gqcEboVi7OQff/SvlE0TKAIPTJDIggX7rZWslY=";
  };
in
{
  home.file."${osConfig.system.xdg.configDir}/opencode/ponytail".source = ponytail;
}
