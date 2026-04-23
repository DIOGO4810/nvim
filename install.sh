#!/bin/bash
set -e

# Update and install deps
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install -y git neovim python3 python3-pip xclip clangd
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y git neovim python3 python3-pip xclip clang-tools-extra
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install git neovim python@3.11
fi

# Clone config
NVIM_CONFIG="${HOME}/.config/nvim"
[ ! -d "$NVIM_CONFIG" ] && git clone https://github.com/DIOGO4810/nvim-config.git "$NVIM_CONFIG"

# Install plugins
cd "$NVIM_CONFIG"
nvim --headless '+Lazy! sync' '+qa'

# Install LSPs
nvim --headless '+MasonInstall basedpyright ruff' '+qa'
