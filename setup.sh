#!/bin/sh
DOT_FILES=(.vim .gvimrc .xvimrc .vimrc .vimrc.setting.vim .vimrc.plugin.vim ~/.vimrc.keymap.vim .zshrc .tmux.conf .gitconfig .pryrc)
BREW_FORMULAS=(
git
mysql
peco
phantomjs
postgresql
rbenv
reattach-to-user-namespace
redis
ruby-build
the_silver_searcher
tmux
tree
vim
vimpager
wget
zsh
)

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # brew入れる
brew update
for formula in ${BREW_FORMULAS[@]}
do
  brew install $formula
done

for file in ${DOT_FILES[@]}
do
  ln -fs $HOME/dotfiles/$file $HOME/$file
done
mkdir ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim -c ':NeoBundleInstall'
git clone https://gist.github.com/04872df9d66962082dfc2a71113c1966.git ~/.vim/bundle/nerdtree/nerdtree_plugin/grep_menuitem.vim

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh

chsh -s /bin/zsh

echo 'Finish!'
