#!/bin/bash

###############################################################
#
# Build NeoVim on Debian 10.5 / Ubuntu 20.04
#
###############################################################

# Reference

# dependencies
# xclip -> for clipboard functionality 
sudo apt install m4 automake unzip make gcc g++ pkg-config cmake libtool libtool-bin gettext xclip --no-install-recommends

USER="pborges"
DIR="/home/$USER/build/"
WORKFOLDER="neovim"

[ ! -d $DIR ] && mkdir -p $DIR

if [ -d "$DIR/$WORKFOLDER" ]; then
    printf "> Updating existing repository: $WORKFOLDER\n"
    cd $DIR/$WORKFOLDER
    git pull
else
    cd $DIR
    git clone https://github.com/neovim/neovim.git
fi
printf "> Building and installing\n"
cd $DIR/$WORKFOLDER
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
printf "> Setting up default options\n"
mkdir -p /home/$USER/.config/nvim/
echo "set number" > /home/$USER/.config/nvim/vimrc
echo "set relativenumber" >> /home/$USER/.config/nvim/vimrc
printf "> Run ':checkhealth' inside nvim to check status\n"
printf "> Complete!\n"
