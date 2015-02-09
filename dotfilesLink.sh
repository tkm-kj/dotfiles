#!/bin/sh
DOT_FILES=(.vim .vimrc .zshrc .tmux.conf)

for file in ${DOT_FILES[@]} 
do
  ln -fs $HOME/dotfiles/$file $HOME/$file
done

mkdir ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://gist.github.com/5141204.git ~/.vim/bundle/nerdtree/nerdtree_plugin/grep_menuitem.vim
git clone https://github.com/ggreer/the_silver_searcher ag && cd ag && ./build.sh && sudo make install
vim -c ':NeoBundleInstall'
echo 'To install tpm plugins, push Ctrl-t + I and check http://qiita.com/masa2sei/items/94f6d89bbd0c2ffcd53b '
