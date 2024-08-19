#!/bin/bash

sudo -v

# Install devbox
DEVBOX_USE_VERSION=0.12.0
wget --quiet --output-document=/dev/stdout https://get.jetify.com/devbox | bash -s -- -f

# Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm


# Install Stow
install_stow_debian() {
    echo "Detected Debian/Ubuntu. Installing Stow..."
    sudo apt update
    sudo apt install -y stow
}

install_stow_fedora() {
    echo "Detected Fedora. Installing Stow..."
    sudo dnf install -y stow
}

install_stow_arch() {
    echo "Detected Arch Linux. Installing Stow..."
    sudo pacman -Syu --noconfirm stow
}

install_stow_macos() {
    echo "Detected macOS. Installing Stow..."
    brew install stow
}

# Determine the operating system and call the appropriate function
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        install_stow_debian
    elif command -v dnf &> /dev/null; then
        install_stow_fedora
    elif command -v pacman &> /dev/null; then
        install_stow_arch
    else
        echo "Unsupported Linux distribution."
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_stow_macos
else
    echo "Unsupported operating system."
fi


# Stow dotfiles
cd configs
for dir in */; do
    echo "Stowing directory: $dir"
    stow -D $dir
    stow $dir -t ~
done

# Install global Devbox packages
eval "$(devbox global shellenv)"
devbox global install

# Make Devboxed zsh the default shell
# Allows root to change shell without a password
sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
command -v $(devbox global run which zsh) | sudo tee -a /etc/shells

chsh -s $(devbox global run which zsh) $(whoami)
