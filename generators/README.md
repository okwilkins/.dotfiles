# NixOS Generators

As `aspen` configurations expose a `formats.docker` output, which builds a rootfs tarball for container images.

## Running as a Container

### Podman

```bash
# x86_64
NIXOS_SYSTEM=nixos-system-x86_64-linux
TARBALL_PATH=$(nix build .#nixosConfigurations.aspen.config.formats.docker --print-out-paths)/$NIXOS_SYSTEM.tar.xz

# aarch64
NIXOS_SYSTEM=nixos-system-aarch64-linux
TARBALL_PATH=$(nix build .#nixosConfigurations.aspen-aarch64.config.formats.docker --print-out-paths)/$NIXOS_SYSTEM.tar.xz

xz -d -c "$TARBALL_PATH" | podman import - nixos-aspen:latest

podman run \
  -it --rm --privileged \
  --name nixos-aspen \
  --hostname aspen-nixos \
  -v $HOME/.ssh/oli:/etc/ssh/ssh_host_ed25519_key:ro \
  -v ./generators/scripts/container-init.sh:/container-init.sh:ro \
  localhost/nixos-aspen \
  /sw/bin/bash /container-init.sh
```

### Docker

```bash
# x86_64
NIXOS_SYSTEM=nixos-system-x86_64-linux
TARBALL_PATH=$(nix build .#nixosConfigurations.aspen.config.formats.docker --print-out-paths)/$NIXOS_SYSTEM.tar.xz

# aarch64
NIXOS_SYSTEM=nixos-system-aarch64-linux
TARBALL_PATH=$(nix build .#nixosConfigurations.aspen-aarch64.config.formats.docker --print-out-paths)/$NIXOS_SYSTEM.tar.xz

xz -d -c "$TARBALL_PATH" | docker import - nixos-aspen:latest

docker run \
  -it --rm --privileged \
  --name nixos-aspen \
  --hostname aspen-nixos \
  -v "$HOME/.ssh/oli:/etc/ssh/ssh_host_ed25519_key:ro" \
  -v "$(pwd)/generators/scripts/container-init.sh:/container-init.sh:ro" \
  nixos-aspen \
  /sw/bin/bash /container-init.sh
```
