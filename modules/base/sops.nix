{
  inputs,
  config,
  lib,
  ...
}:
{
  sops = {
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    age.sshKeyPaths = map (key: key.path) (
      lib.filter (k: k.type == "ed25519") config.services.openssh.hostKeys
    );
    gnupg.sshKeyPaths = [ ];
  };

  sops.secrets."yubico/u2f_keys" = {
    owner = config.system.username;
    path = "${config.system.xdg.configHome}/Yubico/u2f_keys";
  };

  sops.secrets."talos/homelab" = {
    owner = config.system.username;
    path = "${config.system.xdg.configHome}/talos/config.yaml";
  };

  sops.secrets."ssh_keys/racoon" = {
    owner = config.system.username;
    path = "${config.system.homeDir}/.ssh/id_racoon";
  };

  sops.secrets."ssh_keys/raven" = {
    owner = config.system.username;
    path = "${config.system.homeDir}/.ssh/id_raven";
  };
}
