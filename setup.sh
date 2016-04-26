#!/bin/sh
DOT_FILES=(.vim .gvimrc .xvimrc .vimrc .zshrc .tmux.conf .gitconfig .pryrc)

for file in ${DOT_FILES[@]}
do
  ln -fs $HOME/dotfiles/$file $HOME/$file
done

mkdir ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # brew入れる
brew install the_silver_searcher
brew install reattach-to-user-namespace
vim -c ':NeoBundleInstall'
git clone https://gist.github.com/04872df9d66962082dfc2a71113c1966.git ~/.vim/bundle/nerdtree/nerdtree_plugin/grep_menuitem.vim
sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo 'Finish!'
