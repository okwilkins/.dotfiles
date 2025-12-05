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
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    gnupg.sshKeyPaths = [ ];
  };

  sops.secrets."talos/homelab" = {
    owner = config.system.username;
    path = "${config.system.xdg.configHome}/talos/config.yaml";
  };
}
