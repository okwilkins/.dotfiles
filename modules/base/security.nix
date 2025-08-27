{
  security.pki.certificates = [
    (builtins.readFile ../../certs/talos-homelab-ca.crt)
  ];
}
