#!/bin/bash

# https://streamlink.github.io/install.html#source-code

# System wide configuration

DIR="/home/pborges/build/streamlink"
if [ -d "$DIR" ]; then
     cd "$DIR"
     git pull
else
    git clone https://github.com/streamlink/streamlink.git
fi

cd $DIR
sudo python setup.py install
