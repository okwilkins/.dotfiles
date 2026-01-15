# NixOS Generators

[NixOS Generators](https://github.com/nix-community/nixos-generators/tree/master) allows NixOS configurations to generate outputs for different target formats. These include AWS EC2 images, Docker images and VMs.

```bash
NIXOS_SYSTEM=nixos-system-x86_64-linux

TARBALL_PATH=$(nix build .#nixosConfigurations.aspen.config.formats.docker --print-out-paths)/$NIXOS_SYSTEM.tar.xz
xz -d -c "$TARBALL_PATH" | podman import - nixos-aspen:latest

podman run \
  -it --rm --privileged \
  --name nixos-aspen \
  --hostname aspen-nixos \
  -v $HOME/.ssh/oli:/etc/ssh/ssh_host_ed25519_key:ro \
  localhost/nixos-aspen \
  /sw/bin/bash -c "
    /activate
    source /etc/profile

    echo 'root:x:0:0::/root:/sw/bin/bash' > /etc/passwd;
    echo 'oli:x:1000:100::/home/oli:/sw/bin/bash' >> /etc/passwd;
    chown -R oli: /home/oli
    mkdir -m 1777 /tmp;
    export PATH=/sw/bin:\$PATH;

    HM_GEN=\$(find /nix/store -maxdepth 2 -name activate | grep home-manager-generation | head -n 1 | xargs dirname);

    if [ -n \"\$HM_GEN\" ]; then
       echo \"Found generation: \$HM_GEN\";

       echo 'Attempting standard activation...'
       su oli -c \"export NIX_REMOTE=; \$HM_GEN/activate\" || echo 'Standard activation failed (expected), falling back to manual linking...';

       if [ -d \"\$HM_GEN/home-files\" ]; then
          echo 'Linking files from home-files...'
          su oli -c \"cp -rsf --no-preserve=mode,ownership \$HM_GEN/home-files/. /home/oli/\"
       else
          echo 'No home-files directory found. Configs might be missing, but environment is set.'
       fi

    else
       echo \"ERROR: Could not find Home Manager generation.\";
    fi;

    su - oli -s /sw/bin/zsh"
```

