#!/bin/sh
DOT_FILES=(.vim .vimrc .zshrc .tmux.conf)

for file in ${DOT_FILES[@]} 
do
  ln -fs $HOME/dotfiles/$file $HOME/$file
done

mkdir ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
vim -c ':NeoBundleInstall'
echo 'To install tpm plugin, push Ctrl-I!'
