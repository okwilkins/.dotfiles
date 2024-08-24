#!/bin/bash

# Install devbox
DEVBOX_USE_VERSION=0.12.0
wget --quiet --output-document=/dev/stdout https://get.jetify.com/devbox | bash -s -- -f

# Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm


# Install global Devbox packages
devbox global install
