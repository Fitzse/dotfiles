#!/bin/sh

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone git@github.com:scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone git@github.com:altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
git clone git@github.com:tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
git clone git@github.com:rsmenon/vim-mathematica.git ~/.vim/bundle/vim-mathematica
git clone git@github.com:tpope/vim-surround.git ~/.vim/bundle/vim-surround

cp .vimrc ~/.vimrc
