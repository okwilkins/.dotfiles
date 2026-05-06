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

  openvpnDir = "${inputs.dot-secrets}/openvpn-configs";
  openvpnNames = builtins.attrNames (builtins.readDir openvpnDir);
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

  sops.secrets = {
    "ssh_keys/racoon" = {
      owner = config.system.username;
      path = "${config.system.homeDir}/.ssh/racoon";
    };
    "ssh_keys/raven" = {
      owner = config.system.username;
      path = "${config.system.homeDir}/.ssh/raven";
    };

    "ssh_keys/oli" = {
      owner = config.system.username;
      path = "${config.system.homeDir}/.ssh/oli";
    };

    "nordvpn/username" = { };
    "nordvpn/password" = { };
  }
  // builtins.listToAttrs (
    map (name: {
      name = "openvpn-config/${name}";
      value = {
        sopsFile = "${openvpnDir}/${name}";
        format = "binary";
        path = "/etc/openvpn/${name}";
        mode = "0444";
      };
    }) openvpnNames
  );
}
