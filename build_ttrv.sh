#!/bin/bash

# https://github.com/tildeclub/ttrv

# System wide configuration
# Separate each subreddit with a '+'

DEFAULT_SUBREDDITS="selfhosted+privacy+privacytoolsIO+linux"

# Dependencies
sudo apt install feh --no-install-recommends

DIR="$HOME/build/"
WORKFOLDER="ttrv"

if [ ! -d "$DIR/$WORKFOLDER" ]; then
    git clone https://github.com/tildeclub/ttrv.git
fi

cd "$DIR/$WORKFOLDER"
git pull

# Build virtual environment if it doesn't exist yet
if [ ! -e "$DIR/$WORKFOLDER/$WORKFOLDER/bin/activate" ]; then
    python3 -m venv $WORKFOLDER
fi

source "$DIR/$WORKFOLDER/$WORKFOLDER/bin/activate"
python setup.py install

# Copy sample configuration
if [ ! -e "$HOME/.config/ttrv/ttrv.cfg" ]; then
    ttrv --copy-config
    sed -i "s/enable_media = False/enable_media = True/g"  $HOME/.config/ttrv/ttrv.cfg
    sed -i "s/subreddit = front/subreddit = $DEFAULT_SUBREDDITS/g" $HOME/.config/ttrv/ttrv.cfg
fi

# Copy sample mailcap configuration
if [ ! -e "$HOME/.mailcap" ]; then
    ttrv --copy-mailcap
fi

echo "----"
echo ""
echo "Create the following alias in ~/.bashr:"
echo "alias reddit='source \$HOME/build/ttrv/ttrv/bin/activate && ttrv'"
echo ""
echo "use: 'reddit' to call the application"
echo ""
