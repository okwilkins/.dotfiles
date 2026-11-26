# .dotfiles

> The setup where you can officially say: *"I use Nix and Neovim, btw"* 😎

---

This is an opinionated Nix-based setup and dotfiles to have a hyper-personalised and consistent development environment across every machine.
This setup currently runs on Linux, MacOS and even within containers, EC2 machines and VMs.

The configuration of each application has two ideas in mind:

1. It needs to aid how quickly I can develop. Where possible, Vim keybinds are used. There are *many* CLI tools used to speed up my workflow. I primarily work within the terminal, here are some of the tools I use to make things smooth: [Neovim](https://neovim.io/), [fzf](https://github.com/junegunn/fzf), [ripgrep](https://github.com/BurntSushi/ripgrep), [bat](https://github.com/sharkdp/bat), [exa](https://github.com/ogham/exa), [zoxide](https://github.com/ajeetdsouza/zoxide) and many more.
2. It needs to look good. There are too many setups that optimise only for speed, why not have speed and looks?

## Components

|                                                                | Tools                                                                                |
|----------------------------------------------------------------|--------------------------------------------------------------------------------------|
| **Window Manager**                                             | [Hyprland](https://hypr.land/)                                                       |
| **Terminal**                                                   | [Ghostty](https://ghostty.org/)                                                      |
| **Desktop Shell**                                              | [Noctalia](https://noctalia.dev)                                                     |
| **Display Manager**                                            | [greetd](https://git.sr.ht/~kennylevinsen/greetd) + [Noctalia Greeter](https://github.com/noctalia-dev/noctalia-greeter) |
| **File Manager**                                               | [Yazi](https://github.com/sxyazi/yazi) + [Nautilus](https://apps.gnome.org/Nautilus) |
| **Shell**                                                      | [Zsh](https://www.zsh.org) + [Starship](https://starship.rs)                         |
| **Media Player**                                               | [mpv](https://mpv.io)                                                                |
| **Text Editor**                                                | [Neovim](https://neovim.io)                                                          |
| **Image Viewer**                                               | [imv](https://sr.ht/~exec64/imv)                                                     |
| **Screenshot Software**                                        | [Noctalia](https://noctalia.dev)                                                     |

This setup also include full disk encryption and user auth via Yubikeys. Secrets are maintained and stored via SOPs in a private repo.

## Screenshots

![Alt Text](https://drive.google.com/uc?export=view&id=1FRGqCZ4RS9QigVkTldzHaOeVyJSZVSSE)
![Alt Text](https://drive.google.com/uc?export=view&id=1pJUVzmcKdJU_2lOdGMzKpiKd4rxzCLXh)
![Alt Text](https://drive.google.com/uc?export=view&id=1BuxdYWC8NKWpXXxSmOiyGMO3FgfE0NN1)

## Getting Started

Git clone to the root of your home directory:

```bash
cd ~
git clone https://github.com/okwilkins/.dotfiles
```

To install the setup for a given host run:

```bash
sudo nixos-rebuild switch --flake .#<INSERT HOST>
```

[AirPlay setup](docs/airplay.md)

## Updating pinned GitHub sources

From the repo root, run `npins update` (or `nix run nixpkgs#npins -- update` before your first rebuild).
Review `git diff -- npins/sources.json`, rebuild your host, then commit the lockfile.
The three Obsidian plugins still use manually pinned release files in `home/base/gui/obsidian.nix`.

To track a new source, run `npins add github OWNER REPO --branch main` (omit `--branch` to track release tags),
then reference `pins.<name>` in the Home Manager module that uses it.

## Project Structure

```
├── certs            | Collection of certificates to be installed.
├── config           | Configuration globals used throughout the setup.
├── generators       | Aspen container image definition and startup script.
├── home             | Home-manager applications and config files to be installed for the user.
│   ├── base         | Config for ALL systems.
│   │   ├── core     | Core config like shells and CLI tools.
│   │   ├── gui      | Desktop application settings shared by Linux and macOS.
│   │   └── tui      | Config for TUI-based application shared on all systems.
│   ├── darwin       | Config for MacOS-based systems.
│   └── linux        | Linux desktop, secrets and YubiKey settings.
├── hosts            | Nix and hardware config for individual systems.
│   ├── home-aspen   | Container-based setup for personal use.
│   ├── home-birch   | NixOS setup for my personal laptop.
│   ├── home-oak     | NixOS setup for my high powered desktop.
│   └── work-hamming | Nix Darwin setup for my work laptop.
├── modules          | Shared and platform-specific system settings.
├── npins            | Source pins for Home Manager modules.
├── outputs          | Nix Flake outputs for each host.
└── overlays         | Allows patching of any packages that maybe broken on a particular system.
```

## Thanks To

A big thank you to the following people for their inspiration and help:

- [ThePrimeagen](https://github.com/ThePrimeagen)
- [ryan4yin](https://github.com/ryan4yin)
- [EmergentMind](https://github.com/EmergentMind)
- [Phantas0s](https://github.com/Phantas0s)
- [omerxx](https://github.com/omerxx)
- [vfarcic](https://github.com/vfarcic)
- [elliotminns](https://github.com/elliottminns)
- [vl-cr](https://github.com/vl-cr)
