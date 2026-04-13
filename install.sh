# !/bin/bash
# Install script for dotfiles in a container environment via devcontainer
set -e
# check if root or exit
if [ "$EUID" -ne 0 ]; then
  echo "This install script is designed to be run as root in a container via devcontainer."
  exit
fi

# Update and install necessary packages
apt-get update
apt-get -y install ninja-build gettext cmake curl build-essential git stow ripgrep python3-venv

# Stow dotfiles
mkdir -p $HOME/.config/nvim && stow -d $HOME/dotfiles -t $HOME/.config/nvim nvim

# Install Neovim from source
cd $HOME && git clone https://github.com/neovim/neovim.git
cd neovim && git checkout stable
make CMAKE_BUILD_TYPE=Release && make install

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# Install yazi
cargo install --force yazi-build
apt-get -y install jq
apt-get -y install fzf

