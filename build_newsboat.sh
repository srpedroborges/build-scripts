#!/bin/bash

# https://github.com/newsboat/newsboat

# System wide configuration


# Dependencies
sudo apt install libcurl4-openssl-dev libxml2-dev libstfl-dev libjson-c-dev libssl-dev libncurses5-dev libsqlite3-dev asciidoctor --no-install-recommends
# It also requires rust - https://www.rust-lang.org/tools/install
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


DIR="/home/pborges/build/newsboat"
if [ -d "$DIR" ]; then
     cd "$DIR"
     git pull
else
    git clone https://github.com/newsboat/newsboat.git
fi

cd $DIR
make -j4
sudo make install
