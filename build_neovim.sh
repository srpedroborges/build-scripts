#!/bin/bash

###############################################################
#
# Build NeoVim on Debian 10.5 / Ubuntu 20.04
#
###############################################################

# Reference

# dependencies
# xclip -> for clipboard functionality 
sudo apt install git m4 automake unzip make gcc g++ pkg-config cmake libtool libtool-bin gettext xclip --no-install-recommends

USER="pborges"
DIR="/home/$USER/build/"
WORKFOLDER="neovim"
RUST_INTEGRATION=true

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
VIMRC="/home/$USER/.config/nvim/init.vim"
if [ ! -f $VIMRC ]; then
    mkdir -p /home/$USER/.config/nvim/
    touch $VIMRC
    string=""
    string+='set number'
    string+=$'\n'
    string+='set relativenumber'
    string+=$'\n'
    string+='set relativenumber'
    string+=$'\n'
    string+='set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab'
    string+=$'\n'

    if [ "$RUST_INTEGRATION" = true ]; then
        string+=$'\n'
	string+='"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
        string+=$'\n'
	string+='" RUST INTEGRATION'
        string+=$'\n'
	string+='"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
        string+=$'\n'
        string+=$'\n'
	string+='" https://github.com/rust-lang/rust.vim'
        string+=$'\n'
	string+='syntax enable'
        string+=$'\n'
	string+='filetype plugin indent on'
        string+=$'\n'
        string+=$'\n'
        string+='" Reference'
        string+=$'\n'
        string+='" https://github.com/junegunn/vim-plug'
        string+=$'\n'
        string+=$'\n'
        string+='" Install vim-plug if not found'
        string+=$'\n'
        string+="if empty(glob('~/.config/nvim/autoload/plug.vim'))"
        string+=$'\n'
        string+='       silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs'
        string+=$'\n'
        string+='       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        string+=$'\n'
        string+='endif'
        string+=$'\n'
        string+=$'\n'
        string+="call plug#begin('~/.config/nvim/plugged')"
        string+=$'\n'
        string+=$'\n'
        string+="Plug 'rust-lang/rust.vim'"
        string+=$'\n'
        string+=$'\n'
        string+='" https://github.com/junegunn/vim-plug/issues/897'
        string+=$'\n'
        string+="Plug 'vim-syntastic/syntastic'"
        string+=$'\n'
        string+=$'\n'
        string+='" https://github.com/neoclide/coc.nvim'
        string+=$'\n'
        string+='" requires node:'
        string+=$'\n'
        string+='" curl -sL install-node.now.sh/lts | bash'
        string+=$'\n'
        string+="Plug 'neoclide/coc.nvim', {'branch': 'release'}"
        string+=$'\n'
        string+=$'\n'
        string+="call plug#end()"
        string+=$'\n'
        string+=$'\n'
	string+='" Run PlugInstall if there are missing plugins"'
        string+=$'\n'
	string+="if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))"
        string+=$'\n'
	string+='       autocmd VimEnter * PlugInstall --sync | source $MYVIMRC'
        string+=$'\n'
	string+='endif'
	string+=$'\n'
	string+=$'\n'
	string+="if glob('~/.config/nvim/plugged/syntastic')"
	string+=$'\n'
        string+='       " https://github.com/vim-syntastic/syntastic'
        string+=$'\n'
        string+='	set statusline+=%#warningmsg#'
        string+=$'\n'
        string+='       set statusline+=%{SyntasticStatuslineFlag()}'
        string+=$'\n'
        string+='       set statusline+=%*'
        string+=$'\n'
        string+=$'\n'
        string+='       let g:syntastic_always_populate_loc_list = 1'
        string+=$'\n'
        string+='       let g:syntastic_auto_loc_list = 1'
        string+=$'\n'
        string+='       let g:syntastic_check_on_open = 1'
        string+=$'\n'
        string+='       let g:syntastic_check_on_wq = 0'
        string+=$'\n'
        string+='endif'
    fi

    echo "$string" >> $VIMRC

    # install dependencies for https://github.com/neoclide/coc.nvim
    
    printf "> Input 'y' to install node LTS\n"
    curl -sL install-node.now.sh/lts | sudo bash
    
    printf "> ----------------------------------------------\n"
    printf "> Run inside nvim: :CocInstall coc-rust-analyzer\n"
    printf "> ----------------------------------------------\n"
fi

printf "> Run ':checkhealth' inside nvim to check status\n"
printf "> Complete!\n"
