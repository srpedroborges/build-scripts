#!/bin/bash


# Reference
# https://github.com/veracrypt/VeraCrypt
# 
# https://github.com/wxWidgets/wxWidgets/blob/master/README-GIT.md
# https://www.configserverfirewall.com/ubuntu-linux/mount-veracrypt-volume/

# CLI Usage
# Mount Volume
# sudo veracrypt -t ~/Documents/<veracrypt_volume> /mnt/<directory>
#
# List Mounted Volumes
# veracrypt -t -l
#
# Unmount Volume
# veracrypt -t -d /mnt/<directory>


# dependencies
#sudo apt install yasm libgtk-3-dev make g++ gcc libfuse-dev --no-install-recommends
sudo apt install yasm pkg-config make g++ gcc libfuse-dev --no-install-recommends

DIR="/home/pborges/build/VeraCrypt"

[ ! -d $DIR ] && mkdir -p $DIR

if [ -d "$DIR/VeraCrypt" ]; then
    cd "$DIR/VeraCrypt"
    printf "> Updating Git Repository: VeraCrypt\n"
    git pull
else
    cd $DIR
    git clone https://github.com/veracrypt/VeraCrypt.git
fi

if [ -d "$DIR/wxWidgets" ]; then
    cd "$DIR/wxWidgets"
    printf "> Updating Git Repository: wxWidgets\n"
    git pull
else
    cd $DIR
    git clone https://github.com/wxWidgets/wxWidgets.git --recurse-submodules
fi

printf "> Building Veracrypt...\n"
cd "$DIR/VeraCrypt/src"
make NOGUI=1 WXSTATIC=1 WX_ROOT=$DIR/wxWidgets/ wxbuild
make NOGUI=1 WXSTATIC=1
printf "> Build complete!\n"
printf "> The 'veracrypt' binary should be under '$DIR/VeraCrypt/src/Main/'\n"
