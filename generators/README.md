# NixOS Generators

[NixOS Generators](https://github.com/nix-community/nixos-generators/tree/master) allows NixOS configurations to generate outputs for different target formats. These include AWS EC2 images, Docker images and VMs.

## Running as a Container

### Podman

```bash
NIXOS_SYSTEM=nixos-system-x86_64-linux

TARBALL_PATH=$(nix build .#nixosConfigurations.aspen.config.formats.docker --print-out-paths)/$NIXOS_SYSTEM.tar.xz
xz -d -c "$TARBALL_PATH" | podman import - nixos-aspen:latest

podman run \
  -it --rm --privileged \
  --name nixos-aspen \
  --hostname aspen-nixos \
  -v $HOME/.ssh/oli:/etc/ssh/ssh_host_ed25519_key:ro \
  -v ./scripts/container-init.sh:/container-init.sh:ro \
  localhost/nixos-aspen \
  /sw/bin/bash /container-init.sh
```

### Docker

```bash
NIXOS_SYSTEM=nixos-system-x86_64-linux

TARBALL_PATH=$(nix build .#nixosConfigurations.aspen.config.formats.docker --print-out-paths)/$NIXOS_SYSTEM.tar.xz
xz -d -c "$TARBALL_PATH" | docker import - nixos-aspen:latest

docker run \
  -it --rm --privileged \
  --name nixos-aspen \
  --hostname aspen-nixos \
  -v "$HOME/.ssh/oli:/etc/ssh/ssh_host_ed25519_key:ro" \
  -v "$(pwd)/scripts/container-init.sh:/container-init.sh:ro" \
  nixos-aspen \
  /sw/bin/bash /container-init.sh
```
