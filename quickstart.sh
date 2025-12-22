#!/bin/bash
sudo apt-get install python3-pip luarocks ripgrep fd-find python3-venv

curl https://sh.rustup.rs -sSf | sh
cargo install --locked tree-sitter-cli

# For WSL
# sudo apt install xclip
