{ lib, ... }:
{
  options.knownHosts = lib.mkOption {
    type = lib.types.attrs;
    readOnly = true;
    default =
      lib.attrsets.mapAttrs
        (host: value: {
          hostNames = [ host ];
          publicKey = value.publicKey;
        })
        {
          # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
          "github.com".publicKey =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        };
  };
}
