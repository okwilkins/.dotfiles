{
  inputs,
  config,
  lib,
  ...
}:
let
  ageDir = "${inputs.dot-secrets}/keys/age";
  ageKeyFiles = map (name: "${ageDir}/${name}") (builtins.attrNames (builtins.readDir ageDir));
  ageKeysContent = builtins.concatStringsSep "\n" (map builtins.readFile ageKeyFiles);
in
{
  environment.etc."sops/age/keys.txt" = {
    mode = "0400";
    text = ageKeysContent;
    user = "root";
  };
  sops = {
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    age.keyFile = "/etc/sops/age/keys.txt";
    age.sshKeyPaths = map (key: key.path) (
      lib.filter (k: k.type == "ed25519") config.services.openssh.hostKeys
    );
    gnupg.sshKeyPaths = [ ];
  };

  sops.secrets."ssh_keys/racoon" = {
    owner = config.system.username;
    path = "${config.system.homeDir}/.ssh/racoon";
  };

  sops.secrets."ssh_keys/raven" = {
    owner = config.system.username;
    path = "${config.system.homeDir}/.ssh/raven";
  };

  sops.secrets."ssh_keys/oli" = {
    owner = config.system.username;
    path = "${config.system.homeDir}/.ssh/oli";
  };
}
