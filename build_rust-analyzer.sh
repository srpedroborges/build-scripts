#!/bin/bash

# https://github.com/rust-analyzer/rust-analyzer

# Reference
# https://rust-analyzer.github.io/manual.html#installation
# NeoVim
# 1) Install coc.nvim -> https://github.com/neoclide/coc.nvim
# 2) Run :CocInstall coc-rust-analyzer to install coc-rust-analyzer

# Notes
# Requires rust installed.
# .cargo/bin needs to be added to the $PATH

# System wide configuration

DIR="/home/pborges/build/"
WORKFOLDER="rust-analyzer"
cd $DIR
if [ -d "$DIR/$WORKFOLDER" ]; then
     cd "$DIR/$WORKFOLDER"
     git pull
else
    git clone https://github.com/rust-analyzer/rust-analyzer.git && cd $WORKFOLDER
fi
cargo xtask install --server
