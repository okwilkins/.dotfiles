{
  config,
  pkgs,
  osConfig,
  ...
}:
let
  dir = "${osConfig.system.xdg.configDir}/opencode";
  opencodeDir = "${config.home.homeDirectory}/${dir}";
in
{
  imports = [
    ./opencode/plugins.nix
    ./opencode/skills/pstack.nix
  ];

  home.packages = [ pkgs.opencode ];

  home.file."${dir}/cli.json".source = ./opencode/cli.json;
  home.file."${dir}/opencode.json".text = builtins.toJSON (
    builtins.fromJSON (builtins.readFile ./opencode/opencode.json) // {
      skills = [ "${opencodeDir}/pstack/skills" ];
      instructions = [ "${opencodeDir}/pstack-opencode.md" ];
    }
  );
}
