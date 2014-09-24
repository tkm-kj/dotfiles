#!/bin/sh
DOT_FILES=(.vimrc .zshrc .tmux.conf)

for file in ${DOT_FILES[@]} 
do
  ln -fs $HOME/dotfiles/$file $HOME/$file
done

[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle && git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim && cd ~/.vim/ && git clone https://github.com/nanotech/jellybeans.vim.git && mv jellybeans.vim/colors ./ && vim -c ':NeoBundleInstall'
