#!/bin/bash

# https://github.com/blackjack4494/yt-dlc

# System wide configuration

# Dependencies
sudo apt install pandoc --no-install-recommends

DIR="$HOME/build/"
WORKFOLDER="yt-dlc"

if [ ! -d "$DIR/$WORKFOLDER" ]; then
    git clone https://github.com/blackjack4494/yt-dlc.git
fi

cd "$DIR/$WORKFOLDER"
git pull

make

sudo mv youtube-dlc /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

