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
          "git-ssh.okwilkins.dev".publicKey =
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTrFoVlCpjGQszcLnY+jg1YWPLJrySAY12pT935+4aO1hTYjwXTNlWm70A4+ERyNTsBnw3FWEX/pawMB4bmPTMbLWExJoF+X6AA5z3EEysv8P5VGD/4ZlxntH4KhY49sdgMIebDK9nHAcbWU0Bf3CsQTW5LPk0IARpoxYBdHufGR+gd2lBGbhLaZPlCJri1TBk4kOcYG8u5N7Lyh+ymRq0kT58g7z2Syis2bCsqG/Jzc80bKaGpK9ZEkWfWnp0v8r8amT4ExkeKBSAbiKMz6slwu7tL42q3rPCcJAMScXtE3EZKB0iw0+/DXWAHQV/ik7Wj416wxCB0yvCfGARCwOqCpW4LBz+YK9dXUwqxyZpvBvQqPGkPhvyxpR2EDW1AxAEXchQ6eUILiamJpg71HDDyyaAqHA4VjADTwHZlCe8zmmkucEiYjlu0eq5mt3Z9qG+FXo+ld7qvpyQXCzmSuW/YiTsaAWXL9vZYzR9I+5OWe73U2+j6uuFY6OksEq4Fmq5Qw2Jio/rg4ZJGKQdo90ViFy7z42JTwBhWxIbIBNzbUxazj8z0Od5U5y9cTIV2/xjVwXytduPpM5cDM/1/1vXNt2b/wZftrL2vsTFL1ZMI1lBxrTuXf6ANsDOaPE7aBwIjEaIN+DDGvvSC4Pn9i0v089Cc+Z+ORnW3I/+LIzJpQ==";
        };
  };
}
