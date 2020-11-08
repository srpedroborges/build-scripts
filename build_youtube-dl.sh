#!/bin/bash

# https://github.com/blackjack4494/yt-dlc

# System wide configuration

# Dependencies
sudo apt install git make pandoc python3 --no-install-recommends

if [ ! -f /usr/bin/python ]; then
	echo "Creating symlink from '/usr/bin/python3' to '/usr/bin/python'"
	sudo ln -s /usr/bin/python3 /usr/bin/python
fi

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

