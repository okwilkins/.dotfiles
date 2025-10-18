{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  uutilsCommands = lib.splitString "\n" (
    builtins.readFile (
      pkgs.runCommand "uutils-coreutils-list" {
        nativeBuildInputs = [ pkgs.uutils-coreutils ];
      } ''uutils-coreutils --list > $out''
    )
  );
  aliasesFileContent = lib.concatStringsSep "\n" (
    lib.map (command: "alias ${command}=\"uutils-coreutils ${command}\"") (
      # uutils-coreutils --list for some reason includes [ in its list?
      lib.filter (cmd: cmd != "" && cmd != "[") uutilsCommands
    )
  );
in
{

  home.file."${osConfig.system.xdg.configDir}/zsh/aliases/uutils-coreutils-aliases.zsh" = {
    text = aliasesFileContent;
  };
}
