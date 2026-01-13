# NixOS Generators

[NixOS Generators](https://github.com/nix-community/nixos-generators/tree/master) allows NixOS configurations to generate outputs for different target formats. These include AWS EC2 images, Docker images and VMs.

```bash
nix build .#nixosConfigurations.aspen.config.formats.docker

docker import result/nixos-system-x86_64-linux.tar.xz my-nixos-image:latest
...
```
