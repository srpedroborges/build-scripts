#!/bin/bash

# https://streamlink.github.io/install.html#source-code

# To uninstall, remove streamlink directory in:
# /usr/local/lib/python3.8/dist-packages
# and the binary in:
# /usr/local/bin/streamlink


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
