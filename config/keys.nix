{ lib, ... }:
{

  options.keys = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    readOnly = true;
    default = [
      # These keys were generated with my Yubikeys, to generate more run:
      # ssh-keygen -t ed25519-sk -N "" -C "<EMAIL>" -f <FILE LOC>
      # racoon
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIH4AQrahpVqwh6eDbB71pBwGBh+tlLRFqTfXyuB+qtlTAAAABHNzaDo= okwilkins@googlemail.com"
      # raven
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBDTUkI3Zvgl91ULeoD5YjoN67ldfuRdc3aZuN3CKDhKAAAABHNzaDo= okwilkins@googlemail.com
      "
    ];
  };
}
