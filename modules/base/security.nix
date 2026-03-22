{
  security.sudo = {
    # Set sudo timeout to 30mins
    extraConfig = ''
      Defaults timestamp_timeout=30
    '';
  };

  # Automatically read all certificate files from the certs directory
  security.pki.certificates =
    let
      certsDir = ../../certs;
      certFiles = builtins.attrNames (builtins.readDir certsDir);
      isCertFile = name: builtins.match ".*\\.(crt|pem)$" name != null;
      certPaths = map (name: certsDir + "/${name}") (builtins.filter isCertFile certFiles);
    in
    map builtins.readFile certPaths;
}
