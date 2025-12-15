{
  inputs,
  pkgs,
  osConfig,
  ...
}:
let
  secretsDir = builtins.toString inputs.dot-secrets;
  secretsFile = "${secretsDir}/secrets.yaml";

  ageDir = "${inputs.dot-secrets}/keys/age";
  ageKeyFiles = map (name: "${ageDir}/${name}") (builtins.attrNames (builtins.readDir ageDir));
  ageKeyFile = pkgs.writeText "age-identities" (
    builtins.concatStringsSep "\n" (map builtins.readFile ageKeyFiles)
  );
in
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  home.packages = with pkgs; [
    sops
    age-plugin-fido2-hmac
    pam_u2f
  ];

  home.file."${osConfig.system.xdg.configDir}/sops/age-keys" = {
    source = ageKeyFile;
  };

  home.file.".ssh/" = {
    source = "${inputs.dot-secrets}/keys/ssh";
    recursive = true;
  };

  sops = {
    age.sshKeyPaths = [
      "${osConfig.system.homeDir}/.ssh/oli"
    ];
    # age.keyFile = "${osConfig.system.xdg.configDir}/sops/age-keys";
    defaultSopsFile = "${secretsFile}";
  };

  sops.secrets."yubico/u2f_keys" = {
    path = "${osConfig.system.xdg.configHome}/Yubico/u2f_keys";
  };

  sops.secrets."talos/homelab" = {
    path = "${osConfig.system.xdg.configHome}/talos/talosconfig";
  };
}
