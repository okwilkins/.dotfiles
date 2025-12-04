{ config, lib, ... }:
{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = map (key: key.path) (
      lib.filter (k: k.type == "ed25519") config.services.openssh.hostKeys
    );
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
    gnupg.sshKeyPaths = [ ];
    secrets.test_secret = { };
  };
}
