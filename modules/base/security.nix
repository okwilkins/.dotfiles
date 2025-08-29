{
  security.sudo = {
    # Set sudo timeout to 30mins
    extraConfig = ''
      Defaults timestamp_timeout=30
    '';
  };
  security.pki.certificates = [
    (builtins.readFile ../../certs/talos-homelab-ca.crt)
  ];
}
